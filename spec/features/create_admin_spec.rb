# frozen_string_literal: true

require 'rails_helper'

describe 'Create Admin', :feature, js: true do
  before(:all) do
    puts "Initial Submitter count in before(:all): #{Submitter.count}"
  end

  before do
    Submitter.destroy_all
    puts "Initial Submitter count: #{Submitter.count}"
    20.times do
      submitter = FactoryBot.create(:submitter)
      FactoryBot.create(:book, submitter: submitter)
      FactoryBot.create(:other_publication, submitter: submitter)
      FactoryBot.create(:journal_article, submitter: submitter)
      FactoryBot.create(:editing, submitter: submitter)
      FactoryBot.create(:artwork, submitter: submitter)
      FactoryBot.create(:book_chapter, submitter: submitter)
      FactoryBot.create(:photography, submitter: submitter)
      FactoryBot.create(:play, submitter: submitter)
      FactoryBot.create(:musical_score, submitter: submitter)
      FactoryBot.create(:physical_medium, submitter: submitter)
      FactoryBot.create(:digital_project, submitter: submitter)
      FactoryBot.create(:public_performance, submitter: submitter)
      FactoryBot.create(:film, submitter: submitter)
    end
    puts "Final Submitter count: #{Submitter.count}"
    puts "Final Book count: #{Book.count}"
  end

  it 'should have the correct number of submitters' do
    expect(Submitter.count).to eq(20)
    expect(Book.count).to eq(20)

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
