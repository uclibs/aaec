# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AdminController, type: :controller do
  let(:valid_attributes) do
    { 'username' => ENV['ADMIN_USERNAME'], 'password' => ENV['ADMIN_PASSWORD'] }
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
