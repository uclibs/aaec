# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AdminController, type: :controller do
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
end
