# frozen_string_literal: true

# We are verifying access to user profile view and edit pages.

# The application is within open dates.
# The user has a valid authentication token.
# The user is logged in as either a submitter or admin
require 'rails_helper'

RSpec.describe 'Submitter Profile Ownership', type: :feature do
  let(:submitter) { FactoryBot.create(:submitter) }
  let(:another_submitter) { FactoryBot.create(:submitter) }

  before do
    submitter
    another_submitter
  end

  context 'when admin is logged in' do
    before do
      login_as_admin
    end

    it 'allows access to the submitter profile page' do
      visit submitter_path(submitter.id)
      expect(page).to have_http_status(:ok)
    end

    it 'allows access to the edit-submitter profile page' do
      visit edit_submitter_path(submitter.id)
      expect(page).to have_http_status(:ok)
    end
  end

  context 'when submitter owns the resource' do
    before do
      create_submitter(submitter)
    end

    it 'allows access to the submitter profile page' do
      find('a[href*="submitters/"][href*="/edit"]').click
      click_button 'Next' # This is the only way to get to the submitter profile page
      expect(page).to have_http_status(:ok)
    end

    it 'allows access to the edit submitter profile page' do
      find('a[href*="submitters/"][href*="/edit"]').click
      expect(page).to have_http_status(:ok)
    end
  end

  context 'when another submitter is logged in' do
    before do
      create_submitter(submitter)
    end

    it 'restricts access to the submitter profile page' do
      create_submitter(submitter)
      expect { visit submitter_path(another_submitter.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'restricts access to the edit-submitter profile page' do
      create_submitter(submitter)
      expect { visit edit_submitter_path(another_submitter.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
