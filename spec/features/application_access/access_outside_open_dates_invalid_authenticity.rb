# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Application Behavior', type: :feature do
  let(:submitter) { FactoryBot.build(:submitter) }
  let(:expected_admin_content) { ['Submitters (', 'Artworks (', 'Books (', 'Book Chapters ('] }
  let(:expected_submitter_content) { ['Instructions', 'Contact Information', 'Artworks', 'Books', 'Book Chapters'] }

  def go_to_publications_page_as_submitter
    create_submitter(submitter)
    visit publications_path
  end

  def go_to_publications_page_as_admin
    visit manage_path
    fill_in('username', with: ENV.fetch('ADMIN_USERNAME', nil))
    fill_in('password', with: ENV.fetch('ADMIN_PASSWORD', nil))
    click_on('Submit')
    visit publications_path
  end

  before do
    allow(ENV).to receive(:fetch).and_call_original
  end

  # Scenario 1 & 2: Accessing outside open dates with an invalid authenticity token
  context 'when accessing outside open dates and with an invalid authenticity token' do
    it 'redirects to a closed page and logs an invalid token error' do
      # Test implementation
    end
  end
end
