# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CollegesController, type: :controller do
  let(:valid_attributes) { { name: 'Test' } }

  let(:submitter) { FactoryBot.create(:submitter) }
  let(:valid_session) { { submitter_id: submitter.id } }

  describe 'GET #show' do
    let(:college) { College.create! valid_attributes }

    context 'as an admin user' do
      before { session[:admin] = true }

      it 'returns a success response' do
        get :show, params: { id: college.to_param }
        expect(response).to be_successful
      end
    end

    context 'as a non-admin user' do
      before { session[:admin] = false }

      it 'denies access and renders a 404 page' do
        get :show, params: { id: college.to_param }, session: valid_session
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
