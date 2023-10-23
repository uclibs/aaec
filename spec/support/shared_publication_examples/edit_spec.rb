# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'a publication with edit action' do |model_name, valid_params, invalid_params|
  describe 'GET #edit' do
    context 'as the correct submitter' do
      context 'with valid params' do
        before { login_as_submitter_of(model_name) }

        it 'returns a success response' do
          get :edit, params: { id: model_name.to_param, **valid_params }
          expect(response).to be_successful
          expect(response).to render_template('show')
        end
      end

      context 'with invalid params' do
        before { login_as_submitter_of(model_name) }

        it "returns a success response (i.e. to display the 'edit' template)" do
          get :edit, params: { id: model_name.to_param, **invalid_params }
          expect(response).to be_successful
          expect(response).to render_template('edit')
          expect flash[:danger].to be_present
        end
      end
    end

    context 'as the incorrect submitter' do
      before do
        new_submitter = FactoryBot.create(:submitter)
        session[:submitter_id] = new_submitter.id
      end

      it 'redirects to the 404 page' do
        get :edit, params: { id: model_name.to_param }
        expect(response).to redirect_to('/errors/404')
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'as an admin' do
      before do
        session[:admin] = true
        session[:submitter_id] = nil
      end
      it 'returns a success response' do
        get :edit, params: { id: model_name.to_param }
        expect(response).to be_successful
        expect(response).to render_template('show')
      end
    end
  end
end
