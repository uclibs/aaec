# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Authenticity and Date Checks', type: :request do
  before do
    allow_any_instance_of(ApplicationController).to receive(:verify_authenticity_token) do |instance|
      raise ActionController::InvalidAuthenticityToken if instance.request.headers['_csrf_token'] == 'invalid_token'
    end
  end

  it 'redirects to closed page when app is out of date and token is invalid' do
    allow(ENV).to receive(:fetch).with('EXPIRATION_DATE').and_return('2000-01-01')

    warn_count = 0
    allow(Rails.logger).to receive(:warn) do |arg|
      warn_count += 1 if arg.match?(/InvalidAuthenticityToken occurred:/)
    end

    get publications_path, headers: { '_csrf_token' => 'invalid_token' }

    expect(response).to have_http_status(:redirect) # 302
    expect(response).to redirect_to(root_path)
    follow_redirect!

    expect(warn_count).to eq(1)
    expect(response).to have_http_status(:redirect) # 302
    expect(response).to redirect_to('/pages/closed')

    # Reset the received count for :warn calls on Rails.logger
    allow(Rails.logger).to receive(:warn).once

    expect(warn_count).to eq(1)
  end
end
