# frozen_string_literal: true

require 'rails_helper'

describe 'Create Admin', :feature, js: true do
  before do
    (1..20).each do |i|
      submitter = Submitter.find_or_create_by(id: i) do |s|
        attributes = FactoryBot.attributes_for(:submitter)
        s.assign_attributes(attributes)
      end
      FactoryBot.create(:book, submitter:)
      FactoryBot.create(:other_publication, submitter:)
      FactoryBot.create(:journal_article, submitter:)
      FactoryBot.create(:editing, submitter:)
      FactoryBot.create(:artwork, submitter:)
      FactoryBot.create(:book_chapter, submitter:)
      FactoryBot.create(:photography, submitter:)
      FactoryBot.create(:play, submitter:)
      FactoryBot.create(:musical_score, submitter:)
      FactoryBot.create(:physical_medium, submitter:)
      FactoryBot.create(:digital_project, submitter:)
      FactoryBot.create(:public_performance, submitter:)
      FactoryBot.create(:film, submitter:)
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
    expect(page).to have_text 'Books (1)'
    expect(page).to have_text 'Other Publications (1)'
    expect(page).to have_text 'Artworks (1)'
    expect(page).to have_text 'Book Chapters (1)'
    expect(page).to have_text 'Editing (1)'
    expect(page).to have_text 'Journal Articles (1)'
    expect(page).to have_text 'Photography (1)'
    expect(page).to have_text 'Plays (1)'
    expect(page).to have_text 'Musical Scores (1)'
    expect(page).to have_text 'Physical Media (1)'
    expect(page).to have_text 'Digital Projects (1)'
    expect(page).to have_text 'Public Performances (1)'
    expect(page).to have_text 'Films (1)'
    expect(page).not_to have_css('.btn', text: 'New')
    expect(page).not_to have_css('.pagination')

    # Signout
    visit finished_path
    expect(page).to have_current_path(root_path)
    visit publications_path
    expect(page).to have_current_path(root_path)
  end
end
