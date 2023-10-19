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

    get publications_path, headers: { '_csrf_token' => 'invalid_token' }

    expect(response).to redirect_to(root_path)
    follow_redirect!

    expect(response).to redirect_to('/pages/closed')
  end
end
