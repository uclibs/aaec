# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CollegesController, type: :controller do
  let(:submitter) { FactoryBot.create(:submitter) }
  let(:valid_session) { { submitter_id: submitter.id } }

  describe 'GET #new' do
    context 'as an admin user' do
      before { session[:admin] = true }

      it 'returns a success response' do
        get :new, params: {}
        expect(response).to be_successful
      end
    end

    context 'as a non-admin user' do
      before { session[:admin] = false }

      it 'denies access and renders a 404 page' do
        get :new, params: {}, session: valid_session
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
