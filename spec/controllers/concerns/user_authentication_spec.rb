# frozen_string_literal: true

# spec/controllers/concerns/user_authentication_spec.rb

require 'rails_helper'

RSpec.describe UserAuthentication, type: :controller do
  # Create a dummy controller that includes the concern
  controller(ApplicationController) do
    include UserAuthentication

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
        expect(flash[:alert]).to eq('You must submit your information first.')
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
        submitter = FactoryBot.create(:submitter) # Replace with however you create a Submitter in your tests
        session[:submitter_id] = submitter.id
        get :index
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'handle_invalid_token' do
    it 'resets the session and redirects to the login path' do
      routes.draw { get 'index' => 'anonymous#index' }

      # Simulate InvalidAuthenticityToken exception
      expect(controller).to receive(:index).and_raise(ActionController::InvalidAuthenticityToken)

      session[:admin] = true
      get :index

      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq('Your session has expired. Please log in again.')
    end
  end
end
