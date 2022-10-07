# frozen_string_literal: true

require 'rails_helper'

describe 'Create Admin', :feature, js: true do
  before do
    20.times do
      FactoryBot.create(:submitter)
      FactoryBot.create(:book)
      FactoryBot.create(:other_publication)
      FactoryBot.create(:journal_article)
      FactoryBot.create(:editing)
      FactoryBot.create(:artwork)
      FactoryBot.create(:book_chapter)
      FactoryBot.create(:photography)
      FactoryBot.create(:play)
      FactoryBot.create(:musical_score)
      FactoryBot.create(:physical_medium)
      FactoryBot.create(:digital_project)
      FactoryBot.create(:public_performance)
      FactoryBot.create(:film)
    end
  end

  it 'from admin path' do
    # NOTE: There is no link from any page to the manage_path
    visit manage_path

    # Admin Login Page
    fill_in('username', with: ENV.fetch('ADMIN_USERNAME', nil))
    fill_in('password', with: ENV.fetch('ADMIN_PASSWORD', nil))
    click_on('Submit')
    expect(page).to have_current_path(Rails.application.routes.url_helpers.publications_path)

    # Check values
    page.current_window.resize_to(1920, 1080)
    page.save_screenshot('~/screenshot.png')
    expect(page).to have_css('#publications_link', text: 'All Publications')
    expect(page).to have_text 'Submitters (20)'
    expect(page).to have_text 'Books (20)'
    expect(page).to have_text 'Other Publications (20)'
    expect(page).to have_text 'Artworks (20)'
    expect(page).to have_text 'Book Chapters (20)'
    expect(page).to have_text 'Editing (20)'
    expect(page).to have_text 'Journal Articles (20)'
    expect(page).to have_text 'Photography (20)'
    expect(page).to have_text 'Plays (20)'
    expect(page).to have_text 'Musical Scores (20)'
    expect(page).to have_text 'Physical Media (20)'
    expect(page).to have_text 'Digital Projects (20)'
    expect(page).to have_text 'Public Performances (20)'
    expect(page).to have_text 'Films (20)'
    expect(page).to have_css('.pagination', text: '1')
    expect(page).not_to have_css('.pagination', text: '3')

    # Test Admin Submitter Filter
    visit "#{publications_path}/2"
    expect(page).to have_text 'Submitter #2'
    expect(page).to have_text 'Books (0)'
    expect(page).to have_text 'Other Publications (0)'
    expect(page).to have_text 'Artworks (0)'
    expect(page).to have_text 'Book Chapters (0)'
    expect(page).to have_text 'Editing (0)'
    expect(page).to have_text 'Journal Articles (0)'
    expect(page).to have_text 'Photography (0)'
    expect(page).to have_text 'Plays (0)'
    expect(page).to have_text 'Musical Scores (0)'
    expect(page).to have_text 'Physical Media (0)'
    expect(page).to have_text 'Digital Projects (0)'
    expect(page).to have_text 'Public Performances (0)'
    expect(page).to have_text 'Films (0)'
    expect(page).not_to have_css('.btn', text: 'New')
    expect(page).not_to have_css('.pagination')

    # Signout
    visit finished_path
    expect(page).to have_current_path(root_path)
    visit publications_path
    expect(page).to have_current_path(root_path)
  end
end
