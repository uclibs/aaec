# frozen_string_literal: true

require 'rails_helper'

describe 'Create submitter', :feature, js: true do
  let(:submitter) { FactoryBot.build(:submitter) }
  let(:book) { FactoryBot.build(:book) }

  it 'from submitter new page' do
    visit root_path

    # New Submitter Page
    fill_in('submitter[first_name]', with: submitter.first_name)
    fill_in('submitter[last_name]', with: submitter.last_name)
    find_by_id('submitter_college').find("option[value='#{submitter.college}']").select_option
    fill_in('submitter[department]', with: submitter.department)
    fill_in('submitter[mailing_address]', with: submitter.mailing_address)
    fill_in('submitter[phone_number]', with: submitter.phone_number)
    fill_in('submitter[email_address]', with: submitter.email_address)
    click_on('Submit')

    # Valid Submission Redirect
    expect(page).to have_current_path(Rails.application.routes.url_helpers.publications_path)
    expect(page).to have_text 'First Last'
    expect(page).to have_text 'Arts and Sciences'
    expect(page).to have_text 'Department'
    expect(page).to have_text 'Home Address'
    expect(page).to have_text '111-111-1111'
    expect(page).to have_text 'test@mail.uc.edu'
  end
end
