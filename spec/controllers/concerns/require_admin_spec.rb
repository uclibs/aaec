# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RequireAdmin, type: :controller do
  controller(ApplicationController) do
    include RequireAdmin
    def index; end
  end

  let(:submitter) { FactoryBot.create(:submitter) }
  let(:valid_session) { { submitter_id: submitter.id } }

  describe 'GET #index' do
    context 'when admin is not logged in but a submitter is' do
      it 'renders the 404 page' do
        get :index, valid_session
        expect(response).to have_http_status(:not_found)
        expect(response).to render_template('errors/404')
      end
    end

    context 'when neither an admin nor submitter is logged in' do
      it 'redirects to the root page page' do
        get :index
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when admin is logged in' do
      before do
        session[:admin] = true
      end

      it 'allows access' do
        get :index
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
