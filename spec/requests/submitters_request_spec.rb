# frozen_string_literal: true

require 'rails_helper'

# RSpec test suite for the 'Submitters' context, specifically for the
# 'GET /finished' endpoint. The suite tests the following behavior:
# 1. Users who are not logged in and attempt to access the '/finished'
# path should be redirected to the root path.
# 2. A flash warning should be displayed following this redirection,
# informing the user that they must submit their information first.
#
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
