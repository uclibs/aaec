# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AdminController, type: :controller do
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
