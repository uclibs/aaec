# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'a publication with update action' do |model_name, valid_params, invalid_params, new_params|
  let(:submitter) { FactoryBot.create(:submitter) }
  let(:publication) { FactoryBot.create(model_name, submitter:, **valid_params) }
  let(:admin_session) { { admin: true } }
  let(:submitter_session) { { submitter_id: submitter.id } }

  before do
    publication
    new_attributes
    submitter_session
    admin_session
  end

  describe 'PUT #update' do
    context 'when the user is an admin' do
      context 'with valid params' do
        let(:new_attributes) do
          valid_params.merge(**new_params)
        end

        it 'updates the requested publication' do
          expect(OtherPublication.find_by(id: publication.id)).not_to be_nil
          put :update, params: { id: publication.id, "#{model_name}": new_attributes }, session: admin_session
          publication.reload
          new_attributes.each do |attr, value|
            expect(publication.send(attr).to_s).to eq(value.to_s)
          end
          expect(response).to redirect_to(publication)
          expect(flash[:success]).to be_present
        end
      end

      context 'with invalid params' do
        let(:new_attributes) do
          valid_params.merge(**invalid_params)
        end

        it 'does not update, and returns to the edit page with a warning in HTML' do
          put :update, params: { id: publication.id, "#{model_name}": new_attributes }, format: :html, session: admin_session

          publication.reload
          invalid_params.each do |attr, value|
            if publication.respond_to?(attr)
              expect(publication.send(attr)).to_not eq(value.to_s)
            end
          end
          expect(response).to render_template('edit')
        end

        it 'returns an error in JSON' do
          put :update, params: { id: publication.id, "#{model_name}": new_attributes }, format: :json, session: admin_session
          json_response = JSON.parse(response.body)
          invalid_params.each do |attr, _value|
            if publication.respond_to?(attr)
              expect(json_response[attr.to_s]).to be_present
            end
          end
        end
      end
    end

    context 'when the user is a submitter' do
      before { login_as_submitter_of(publication)}

      context 'with valid params' do
        let(:new_attributes) do
          valid_params.merge(**new_params.except('submitter_id'))
        end

        it 'updates the requested publication (except submitter_id)' do
          puts "new attributes are: #{new_attributes}"

          expect(new_attributes).not_to include('submitter_id')

          expect(OtherPublication.find_by(id: publication.id)).not_to be_nil
          put :update, params: { id: publication.id, "#{model_name}": new_attributes }
          publication.reload
          new_attributes.each do |attr, value|
            expect(publication.send(attr).to_s).to eq(value.to_s)
          end
          expect(response).to redirect_to(publication)
        end
      end

      context 'with invalid params' do
        let(:new_attributes) do
          valid_params.merge(**invalid_params.except('submitter_id'))
        end

        it 'does not update, and returns to the edit page with a warning in HTML' do
          put :update, params: { id: publication.id, "#{model_name}": new_attributes }, format: :html

          publication.reload
          invalid_params.each do |attr, value|
            if publication.respond_to?(attr)
              expect(publication.send(attr)).to_not eq(value.to_s)
            end
          end
          expect(response).to render_template('edit')
        end

        it 'returns an error in JSON' do
          put :update, params: { id: publication.id, "#{model_name}": new_attributes }, format: :json
          puts response.body
          json_response = JSON.parse(response.body)
          expect(json_response['errors']).to be_present
        end
      end
    end
  end
end
