# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Authenticity and Date Checks', type: :request do
  before do
    # Stub ApplicationController to raise an exception for invalid CSRF token
    allow_any_instance_of(ApplicationController).to receive(:verify_authenticity_token) do |instance|
      raise ActionController::InvalidAuthenticityToken if instance.request.headers['_csrf_token'] == 'invalid_token'
    end
  end

  #     expect(response).to have_http_status(:redirect) # 302
  #     expect(response).to redirect_to(root_path)
  #     follow_redirect!
  
  #     expect(warn_count).to eq(1)
  #     expect(response).to have_http_status(:redirect) # 302
  #     expect(response).to redirect_to('/pages/closed')
  
  #     # Reset the received count for :warn calls on Rails.logger
  #     allow(Rails.logger).to receive(:warn).once
  
  #     expect(warn_count).to eq(1)
  #   end
  # end

  context 'when app is out of date and token is invalid' do
    it 'redirects to closed page and logs a warning' do
      # Stub the expiration date to a past date
      allow(ENV).to receive(:fetch).with('EXPIRATION_DATE').and_return('2000-01-01')

      # Setup to count warnings related to InvalidAuthenticityToken
      warn_count = 0
      allow(Rails.logger).to receive(:warn) do |arg|
        puts "WARN: #{arg}"
        warn_count += 1 if arg.match?(/InvalidAuthenticityToken occurred:/)
      end

      # Perform the GET request with an invalid CSRF token
      get publications_path, headers: { '_csrf_token' => 'invalid_token' }
      puts "INFO: Response: #{response.inspect}"
      puts "The date was: #{Date.parse(ENV.fetch('EXPIRATION_DATE'))}"
      puts "the response body was: #{response.body}"
      # Check the response for redirection
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(root_path)

      # Verify that the warning was logged once
      expect(warn_count).to eq(1)
    end
  end
end
