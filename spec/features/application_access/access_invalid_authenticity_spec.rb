# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Handling of invalid authenticity token', type: :feature, js: true do
  let(:submitter) { FactoryBot.create(:submitter) }

  before do
    ActionController::Base.allow_forgery_protection = true
  end

  after do
    ActionController::Base.allow_forgery_protection = false
  end

  context 'when trying to log in' do
    context 'as a submitter' do
      it 'triggers an inauthentic token error and redirects to the root path' do
        visit root_path
        fill_in('submitter[first_name]', with: submitter.first_name)
        fill_in('submitter[last_name]', with: submitter.last_name)
        find_by_id('submitter_college').find(:xpath, "option[#{submitter.college}]").select_option
        fill_in('submitter[department]', with: submitter.department)
        fill_in('submitter[mailing_address]', with: submitter.mailing_address)
        fill_in('submitter[phone_number]', with: submitter.phone_number)
        fill_in('submitter[email_address]', with: submitter.email_address)
        make_authenticity_token_invalid
        click_on('Next')
        expect_to_be_on_root_page_with_expired_error
      end
    end

    context 'as an admin' do
      before do
        allow(ENV).to receive(:fetch).and_call_original
      end
      context 'when the user was previously in an admin session' do
        # We are assuming that the previous session was an admin session.
        # If it were not, then the user would be redirected to the root path.
        it 'triggers an inauthentic token error and redirects to the manage path' do
          visit_publications_page_as_admin
          visit manage_path
          fill_in('username', with: ENV.fetch('ADMIN_USERNAME', nil))
          fill_in('password', with: ENV.fetch('ADMIN_PASSWORD', nil))
          make_authenticity_token_invalid
          click_on('Submit')
          expect_to_be_on_manage_page_with_expired_error
        end
      end

      context 'when the user was not previously in an admin session' do
        it 'triggers an inauthentic token error and redirects to the root path' do
          # We are assuming that the session[:admin] is not already set.
          # If it were, then the user would be redirected to the manage path.
          visit manage_path
          fill_in('username', with: ENV.fetch('ADMIN_USERNAME', nil))
          fill_in('password', with: ENV.fetch('ADMIN_PASSWORD', nil))
          make_authenticity_token_invalid
          click_on('Submit')
          expect_to_be_on_root_page_with_expired_error
        end
      end
    end
  end

  context 'when trying to add a publication' do
    context 'as a submitter' do
      it 'triggers an inauthentic token error and redirects to the root path' do
        visit_publications_page_as_submitter(submitter)
        first('a', text: 'New').click # There is no authenticity check for this button
        expect(page).to have_current_path(new_artwork_path)
        make_authenticity_token_invalid # New artwork will submit an authenticity token.

        fill_in('artwork[author_first_name][]', with: 'Test')
        fill_in('artwork[author_last_name][]', with: 'Artist')
        fill_in('artwork[work_title]', with: 'Test Artwork')
        click_on('Submit')
        expect_to_be_on_root_page_with_expired_error
      end
    end

    context 'as an admin' do
      before do
        FactoryBot.create(:artwork) # create an artwork to edit
      end
      it 'triggers an inauthentic token error and redirects to the manage path' do
        visit_publications_page_as_admin
        expect(page).to have_current_path(publications_path)
        find('i.fas.fa-edit', match: :first).click
        expect(page).to have_current_path(edit_artwork_path(Artwork.first))
        make_authenticity_token_invalid
        click_on('Submit')
        expect_to_be_on_manage_page_with_expired_error
      end
    end
  end
end
