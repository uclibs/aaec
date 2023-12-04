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

  # Scenario 3: Missing session IDs
  context 'when a user is not logged in' do
    it 'redirects to a login page with a message to submit your information' do
      # No submitter_id or admin=true
      visit publications_path
      expect(response).to redirect_to(root_path)
      expect(page).to have_content('You must submit your information first.')
    end
  end

  context 'when a user is logged in' do
    context 'as a submitter' do
      it 'allows access to the publications page' do
        # submitter_id but not admin=true
        go_to_publications_page_as_submitter
        expected_submitter_content.each do |content|
          expect(page).to have_content(content)
        end
      end
    end

    context 'as an admin' do
      it 'allows access to the publications page' do
        # admin=true but not submitter_id
        go_to_publications_page_as_admin
        expected_admin_content.each do |content|
          expect(page).to have_content(content)
        end
      end
    end

    context 'as an admin and a submitter' do
      # Currently, this scenario is possible though not intended for use.
      it 'allows access to the publications page with an admin view' do
        # admin=true and submitter_id
        create_submitter(submitter)
        go_to_publications_page_as_admin
        expected_admin_content.each do |content|
          expect(page).to have_content(content)
        end
      end
    end
  end
end
