# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExceptionHandlingManager, type: :controller do
  controller(ApplicationController) do
    include ExceptionHandlingManager

    def index
      render plain: 'Hello, world!'
    end
  end

  describe 'handle_invalid_token' do
    it 'resets the session and redirects to the login path' do
      routes.draw { get 'index' => 'anonymous#index' }

      # Create a specific InvalidAuthenticityToken exception
      specific_exception = ActionController::InvalidAuthenticityToken.new('Test Exception Message')

      # Simulate InvalidAuthenticityToken exception
      expect(controller).to receive(:index).and_raise(specific_exception)

      allow(Rails.logger).to receive(:warn)

      # Set a session variable to check if it's reset
      session[:admin] = true

      get :index

      expect(Rails.logger).to have_received(:warn).with(/InvalidAuthenticityToken occurred: Test Exception Message/)
      expect(response).to redirect_to(root_path)
      expect(flash[:danger]).to eq('Your session has expired. Please log in again.')
      expect(session[:admin]).to be_nil
    end
  end
end
