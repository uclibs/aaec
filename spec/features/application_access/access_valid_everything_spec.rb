# frozen_string_literal: true

# The application is within open dates.
# The user has a valid authentication token.
# (Not changed to invalid as in access_invalid_authenticity.rb)
# The user is logged in as either a submitter, an admin, or both.
# The user is allowed to access the publications page.

require 'rails_helper'

RSpec.describe 'Application Behavior', type: :feature, js: true do
  before do
    ActionController::Base.allow_forgery_protection = true
    allow(ENV).to receive(:fetch).and_call_original
    allow(ENV).to receive(:fetch).with('EXPIRATION_DATE').and_return('Jan 01 2099')
  end

  after do
    ActionController::Base.allow_forgery_protection = false
  end

  let(:submitter) { FactoryBot.create(:submitter) }
  let(:expected_admin_content) { ['Submitters (', 'Artworks (', 'Books (', 'Book Chapters ('] }
  let(:expected_submitter_content) { ['Instructions', 'Contact Information', 'Artworks', 'Books', 'Book Chapters'] }

  context 'when the application is within its open dates' do
    context 'as an admin' do
      it 'allows access to the publications page' do
        visit_publications_page_as_admin
        expected_admin_content.each do |content|
          expect(page).to have_content(content)
        end
      end
    end

    context 'as an admin and a submitter' do
      it 'allows access to the publications page with an admin view' do
        # Currently, this scenario is possible though not intended for use.
        create_submitter(submitter)
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
  end
end
