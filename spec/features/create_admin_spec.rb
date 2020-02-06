# frozen_string_literal: true

require 'rails_helper'

describe 'Create Admin', :feature, js: true do
  before do
    20.times do
      FactoryBot.create(:submitter)
      FactoryBot.create(:book)
      FactoryBot.create(:other_publication)
    end
  end

  it 'from admin path' do
    # Note: There is no link from any page to the admin_path
    visit admin_path

    # Admin Login Page
    fill_in('username', with: ENV['ADMIN_USERNAME'])
    fill_in('password', with: ENV['ADMIN_PASSWORD'])
    click_on('Submit')

    expect(page).to have_current_path(Rails.application.routes.url_helpers.publications_path)

    # Check values
    expect(page).to have_text 'Submitters (20)'
    expect(page).to have_text 'Books (20)'
    expect(page).to have_text 'Other Publications (20)'
    expect(page).to have_css('.pagination', text: '1')
    expect(page).not_to have_css('.pagination', text: '3')

    # Test Admin Submitter Filter
    visit publications_path + '/2'
    expect(page).to have_text 'Submitter #2'
    expect(page).to have_text 'Books (0)'
    expect(page).to have_text 'Other Publications (0)'
    expect(page).not_to have_css('.btn', text: 'New')
    expect(page).not_to have_css('.pagination')

    # Signout
    visit signout_path
    expect(page).to have_current_path(root_path)
    visit publications_path
    expect(page).to have_current_path(root_path)
  end
end
