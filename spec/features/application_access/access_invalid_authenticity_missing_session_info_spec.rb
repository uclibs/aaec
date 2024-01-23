# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Application Behavior', type: :feature do
  let(:submitter) { FactoryBot.build(:submitter) }

  before do
    ActionController::Base.allow_forgery_protection = true
  end

  after do
    ActionController::Base.allow_forgery_protection = false
  end

  context 'when an invalid authenticity token is provided along with a missing or invalid session ID' do
    it 'redirects to the root page with an error message' do
      # The user never tries to log in, otherwise they would have a session.
      # The user never gets to fill in information, so there is no authenticity token to make invalid.
      visit publications_path
      expect_to_be_on_root_page_with_login_message
    end

    it 'allows the user to log in after having been redirected to the root page with an error message' do
      visit publications_path
      visit_publications_page_as_submitter(submitter)
      expect(page).to have_current_path(publications_path)
    end
  end
end
