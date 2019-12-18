# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Submitters', type: :request do
  describe 'GET /submitters' do
    it 'works! (now write some real specs)' do
      get submitters_path
      expect(response).to have_http_status(200)
    end
  end
end
