# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Submitters', type: :request do
  describe 'GET /finished' do
    it 'redirects to root with a flash warning if not logged in' do
      get finished_path
      expect(response).to redirect_to(root_path)
      follow_redirect!
      expect(flash[:danger]).to eq('You must submit your information first.')
    end
  end
end
