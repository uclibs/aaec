# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Application Behavior', type: :feature do
  context 'when a user is not logged in' do
    # No submitter_id or admin=true
    it 'redirects to a login page with a message to submit your information' do
      visit publications_path
      expect(current_path).to eq(root_path)
      expect(page).to have_content('You must submit your information first.')
    end
  end
end
