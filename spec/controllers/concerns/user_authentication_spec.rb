# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserAuthentication, type: :controller do
  controller(ApplicationController) do
    def index
      render plain: 'ok'
    end
  end

  describe 'Authentication' do
    before do
      routes.draw { get 'index', to: 'anonymous#index' }
    end

    context 'when no user is authenticated' do
      it 'redirects to the root path with an alert' do
        get :index
        expect(response).to redirect_to(root_path)
        expect(flash[:danger]).to eq('You must submit your information first.')
      end
    end

    context 'when admin is logged in' do
      it 'does not redirect and allows access' do
        session[:admin] = true
        get :index
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when submitter is logged in' do
      it 'does not redirect and allows access' do
        submitter = FactoryBot.create(:submitter)
        session[:submitter_id] = submitter.id
        get :index
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
