# frozen_string_literal: true

# The application is within open dates.
# The user has a valid authentication token.
# (Not changed to invalid as in access_invalid_authenticity.rb)
# The user is logged in as either a submitter, an admin, or both.
# The user is allowed to access the publications page.

require 'rails_helper'

RSpec.describe 'Application Behavior', type: :feature do
  let(:submitter) { FactoryBot.build(:submitter) }
  let(:expected_admin_content) { ['Submitters (', 'Artworks (', 'Books (', 'Book Chapters ('] }
  let(:expected_submitter_content) { ['Instructions', 'Contact Information', 'Artworks', 'Books', 'Book Chapters'] }

  context 'when the application is within its open dates' do
    before do
      allow(ENV).to receive(:fetch).and_call_original
      allow(ENV).to receive(:fetch).with('EXPIRATION_DATE').and_return('Jan 01 2099')
    end

    context 'as an admin' do
      it 'allows access to the publications page' do
        visit_publications_page_as_admin
        expected_admin_content.each do |content|
          expect(page).to have_content(content)
        end
      end
    end

    context 'as a submitter' do
      it 'allows access to the publications page' do
        visit_publications_page_as_submitter(submitter)
        expected_submitter_content.each do |content|
          expect(page).to have_content(content)
        end
      end
    end

    context 'as an admin and a submitter' do
      # Currently, this scenario is possible though not intended for use.
      # admin=true and submitter_id
      it 'allows access to the publications page with an admin view' do
        create_submitter(submitter)
        visit_publications_page_as_admin
        expected_admin_content.each do |content|
          expect(page).to have_content(content)
        end
      end
    end
  end
end
