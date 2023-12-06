# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Application Behavior', type: :feature do
  let(:submitter) { FactoryBot.build(:submitter) }

  before do
    allow(ENV).to receive(:fetch).with('EXPIRATION_DATE').and_return('Jan 01 2000')
    ActionController::Base.allow_forgery_protection = true
  end

  after do
    ActionController::Base.allow_forgery_protection = false
  end

  context 'when accessing outside open dates, with an invalid authenticity token, and a missing or invalid session ID' do
    it 'redirects to a closed page' do
      # The user never tries to log in, otherwise they would have a session.
      # The user never gets to fill in information, so there is no authenticity token to make invalid.
      visit publications_path
      expect(page).to have_content('The deadline for submissions has passed.')
    end
  end
end
