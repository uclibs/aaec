# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CollegesController, type: :controller do
  let(:valid_attributes) { { name: 'Test' } }

  let(:submitter) { FactoryBot.create(:submitter) }
  let(:valid_session) { { submitter_id: submitter.id } }

  describe 'GET #index' do
    context 'as an admin user' do
      before do
        session[:admin] = true
        College.create! valid_attributes
      end

      it 'returns a success response' do
        get :index, params: {}
        expect(response).to be_successful
      end
    end

    context 'as a non-admin user' do
      before do
        College.create! valid_attributes
        session[:admin] = false
      end

      it 'denies access and renders a 404 page' do
        get :index, params: {}, session: valid_session
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
