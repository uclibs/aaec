# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AdminController, type: :controller do
  let(:valid_attributes) do
    { 'username' => ENV.fetch('ADMIN_USERNAME', nil), 'password' => ENV.fetch('ADMIN_PASSWORD', nil) }
  end

  let(:invalid_attributes) do
    { 'username' => 'bad', 'password' => 'invalid' }
  end

  describe 'POST #validate' do
    it 'returns a success response' do
      post :validate, params: valid_attributes
      expect(response).to redirect_to('/publications')
    end

    it 'returns a error response' do
      post :validate, params: invalid_attributes
      expect(response.status).to eq 302
    end
  end

  describe 'GET #login' do
    it 'Visit manage path before expiration date' do
      allow(Date).to receive(:current).and_return Date.parse(ENV.fetch('EXPIRATION_DATE'))
      get(:login, params: { :format => 'html', 'controller_name' => 'admin_controller' }, session: { 'admin' => false })
      expect(response.status).to eq 200
    end

    it 'Visit manage path after expiration date' do
      allow(Date).to receive(:current).and_return Date.parse(ENV.fetch('PAST_DATE'))
      get(:login, params: { :format => 'html', 'controller_name' => 'admin_controller' }, session: { 'admin' => false })
      expect(response.status).to eq 200
    end
  end

  describe 'GET #csv' do
    it 'returns a csv when admin' do
      get(:csv, params: { :format => 'csv', 'controller_name' => 'other_publications' }, session: { 'admin' => true })
      expect(response.status).to eq 200
    end

    it 'redirects when invalid format and admin' do
      get(:csv, params: { :format => 'html', 'controller_name' => 'other_publications' }, session: { 'admin' => true })
      expect(response).to redirect_to('/publications')
    end

    it 'redirects when not admin but valid' do
      get(:csv, params: { :format => 'csv', 'controller_name' => 'other_publications' })
      expect(response).to redirect_to('/publications')
    end
  end
end
