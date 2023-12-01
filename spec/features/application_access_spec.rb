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
    fill_in('username', with: ENV['ADMIN_USERNAME'])
    fill_in('password', with: ENV['ADMIN_PASSWORD'])
    click_on('Submit')
    visit publications_path
  end

  before do
    allow(ENV).to receive(:fetch).and_call_original
  end

  # Scenario 1: Accessing the application outside of its open dates
  context 'when the application is within its open dates' do
    before do
      allow(ENV).to receive(:fetch).with('EXPIRATION_DATE').and_return('Jan 01 2099')
    end

    context 'as an admin' do
      it 'allows access to the publications page' do
        go_to_publications_page_as_admin  
        expected_admin_content.each do |content|
          expect(page).to have_content(content)
        end
      end
    end

    context 'as a submitter' do
      it 'allows access to the publications page' do
        go_to_publications_page_as_submitter
        expected_submitter_content.each do |content|
          expect(page).to have_content(content)
        end
      end
    end
  end

  context 'when the application is outside of its open dates' do
    before do
      allow(ENV).to receive(:fetch).with('EXPIRATION_DATE').and_return('Jan 01 2000')
    end

    context 'as an admin' do
      it 'allows access to the publications page' do
        go_to_publications_page_as_admin
        expected_admin_content.each do |content|
          expect(page).to have_content(content)
        end
      end
    end

    context 'as a submitter' do
      it 'does not allow access to the publications page' do
        go_to_publications_page_as_submitter
        expect(page).to have_content('The deadline for submissions has passed.')
      end
    end
end


  # Scenario 2: Handling invalid authenticity tokens
  context 'when an invalid authenticity token is provided' do
    it 'redirects to a login or error page with an invalid token message' do
      # Test implementation
    end
  end

  # Scenario 3: Missing or invalid session IDs
  context 'when a session ID is missing or invalid' do
    it 'redirects to a login page with a session expired message' do
      # Test implementation
    end
  end

  # Scenario 1 & 2: Accessing outside open dates with an invalid authenticity token
  context 'when accessing outside open dates and with an invalid authenticity token' do
    it 'redirects to a closed page and logs an invalid token error' do
      # Test implementation
    end
  end

  # Scenario 1 & 3: Accessing outside open dates with a missing or invalid session ID
  context 'when accessing outside open dates and with a missing or invalid session ID' do
    it 'redirects to a closed page with a session expired message' do
      # Test implementation
    end
  end

  # Scenario 2 & 3: Invalid authenticity token and missing or invalid session ID
  context 'when an invalid authenticity token is provided along with a missing or invalid session ID' do
    it 'redirects to a login page and logs an invalid token error with a session expired message' do
      # Test implementation
    end
  end

  # Scenario 1, 2 & 3: Combining all three issues
  context 'when accessing outside open dates, with an invalid authenticity token, and a missing or invalid session ID' do
    it 'redirects to a closed page, logs an invalid token error, and indicates a session issue' do
      # Test implementation
    end
  end
end
