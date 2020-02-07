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
end
