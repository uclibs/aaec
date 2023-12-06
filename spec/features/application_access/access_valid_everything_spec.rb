# frozen_string_literal: true

# The application is within open dates.
# The user has a valid authentication token.
# (Not changed to invalid as in access_invalid_authenticity.rb)
# The user is logged in as either a submitter, an admin, or both.
# The user is allowed to access the publications page.

require 'rails_helper'

RSpec.describe 'Application Behavior', type: :feature do
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

      it 'allows an admin to log in with valid credentials' do
        visit manage_path # Replace with the path to your admin login page
    
        # Fill in the login form - replace with your form field identifiers
        fill_in 'username', with: ENV.fetch('ADMIN_USERNAME', 'default_admin')
        fill_in 'password', with: ENV.fetch('ADMIN_PASSWORD', 'default_password')
    
        # Click the submit button - replace with your button text or identifier
        click_on 'Submit'
    
        # Expectations after successful login
        # Replace '/path_after_successful_login' with the path you expect after login
        expect(page).to have_current_path(publications_path)
        expect(page).to have_text('Successfully logged in') # Replace with a success message or content you expect
      end
    


      it 'allows access to the publications page' do
        visit manage_path
        save_and_open_page
        fill_in('username', with: ENV.fetch('ADMIN_USERNAME'))
        fill_in('password', with: ENV.fetch('ADMIN_PASSWORD'))
        click_on('Submit')
        save_and_open_page
        visit publications_path
        # save_and_open_page
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
        # create_submitter(submitter)
        visit_publications_page_as_admin
        expected_admin_content.each do |content|
          expect(page).to have_content(content)
        end
      end
    end
  end
end
