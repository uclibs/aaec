# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Application Behavior', type: :feature do
  let(:submitter) { FactoryBot.build(:submitter) }
  let(:expected_admin_content) { ['Submitters (', 'Artworks (', 'Books (', 'Book Chapters ('] }
  let(:expected_submitter_content) { ['Instructions', 'Contact Information', 'Artworks', 'Books', 'Book Chapters'] }

  # Scenario 1: Accessing the application outside of its open dates
  context 'when the application is outside of its open dates' do
    before do
      allow(ENV).to receive(:fetch).and_call_original
      allow(ENV).to receive(:fetch).with('EXPIRATION_DATE').and_return('Jan 01 2000')
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
      it 'does not allow access to the publications page' do
        visit_publications_page_as_submitter(submitter)
        expect(page).to have_content('The deadline for submissions has passed.')
      end
    end
  end
end
