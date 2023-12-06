# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Application Behavior', type: :feature, js: true do
  before do
    ActionController::Base.allow_forgery_protection = true
    allow(ENV).to receive(:fetch).and_call_original
    allow(ENV).to receive(:fetch).with('EXPIRATION_DATE').and_return('Jan 01 2000')
  end

  after do
    ActionController::Base.allow_forgery_protection = false
  end

  context 'when accessing outside open dates and with an invalid authenticity token' do
    context 'as an admin' do
      before do
        FactoryBot.create(:artwork) # create an artwork to edit
      end
      it 'triggers an inauthentic token error and redirects to the root path' do
        visit_publications_page_as_admin
        expect(page).to have_current_path(publications_path)
        find('i.fas.fa-edit', match: :first).click
        expect(page).to have_current_path(edit_artwork_path(Artwork.first))
        make_authenticity_token_invalid
        click_on('Submit')
        expect_to_be_on_manage_page_with_expired_error
      end
    end

    context 'as a submitter' do
      it 'redirects to the closed page' do
        visit root_path
        # The user never gets to fill in information, so there is no authenticity token to make invalid.
        expect(page).to have_content('The deadline for submissions has passed.')
      end
    end
  end
end
