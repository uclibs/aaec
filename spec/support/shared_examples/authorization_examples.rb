# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'restricts non-logged-in users' do |actions|
  let(:model) { controller.controller_name.classify.constantize }
  let(:record) { FactoryBot.create(model.to_s.underscore.to_sym) }

  let(:submitter) { FactoryBot.create(:submitter) }

  actions.each do |action, method|
    describe "#{method.upcase} ##{action}" do
      before do
        if respond_to?(:admin_session)
          session.merge!(admin_session)
        elsif respond_to?(:submitter_session)
          session[:submitter_id] = submitter.id
        end

        params = case action
                 when 'create'
                   { model.to_s.underscore => FactoryBot.attributes_for(model.to_s.underscore.to_sym) }
                 when 'edit', 'destroy', 'show'
                   { id: record.id }
                 when 'update'
                   update_params = { model.to_s.underscore => FactoryBot.attributes_for(model.to_s.underscore.to_sym) }
                   { id: record.id }.merge(update_params)
                 else
                   {}
                 end
        public_send(method, action, params:)
      end

      context 'when no user is logged in' do
        it 'redirects to the root page' do
          expect(response).to redirect_to(root_path)
        end
      end

      context 'when logged in as a submitter' do
        let(:submitter_session) { { submitter_id: submitter.id } }

        if %w[show new edit].include?(action)
          it 'allows access' do
            expect(response).to be_successful
          end
        elsif action == 'create'
          it 'redirects after successful creation' do
            expect(response).to redirect_to(publications_path)
          end
        elsif action == 'update'
          it 'redirects after successful update' do
            expect(response).to redirect_to(assigns(controller.controller_name.singularize))
            expect(flash[:success]).to match(/#{controller.controller_name.classify} was successfully updated./)
          end
        elsif action == 'destroy'
          it 'redirects after successful destruction' do
            expect(response).to redirect_to(assigns(controller.controller_name.singularize))
            expect(flash[:warning]).to match(/#{controller.controller_name.classify} was successfully destroyed./)
          end
        else
          it 'redirects to the publicatinos page' do
            expect(response).to redirect_to(publications_path)
          end
        end
      end

      context 'when logged in as an admin' do
        let(:admin_session) { { admin: true } }

        case action
        when 'create'
          it 'redirects to the publications page' do
            expect(response).to redirect_to(publications_path)
          end
        when 'index'
          it 'allows access' do
            expect(response).to redirect_to(publications_path)
          end
        when 'update'
          it 'redirects after successful update' do
            expect(response).to redirect_to(assigns(controller.controller_name.singularize))
            expect(flash[:success]).to match(/#{controller.controller_name.classify} was successfully updated./)
          end
        when 'destroy'
          it 'redirects after successful destruction' do
            expect(response).to redirect_to(assigns(controller.controller_name.singularize))
            expect(flash[:warning]).to match(/#{controller.controller_name.classify} was successfully destroyed./)
          end
        else
          it 'allows access' do
            expect(response).to be_successful
          end
        end
      end
    end
  end
end
