# frozen_string_literal: true

require 'rails_helper'

describe 'Create a Artwork', :feature, js: true do
  let(:submitter) { FactoryBot.build(:submitter) }
  let(:artwork) { FactoryBot.build(:artwork) }

  it 'from publications index page' do
    create_submitter(submitter)
    visit publications_path
    find(:xpath, "//a[@href='#{Rails.application.routes.url_helpers.new_artwork_path}']").click

    # New artwork Page
    expect(page).to have_current_path(Rails.application.routes.url_helpers.new_artwork_path)
    (0..artwork.author_first_name.count - 1).each do |i|
      click_on('Add Author') if i != 0
      all(:xpath, "//input[@name='artwork[author_first_name][]']").last.set(artwork.author_first_name[i])
      all(:xpath, "//input[@name='artwork[author_last_name][]']").last.set(artwork.author_last_name[i])
    end
    (0..artwork.college_ids.count - 1).each do |i|
      check "artwork_college_ids_#{artwork.college_ids[i]}"
    end
    fill_in('artwork[uc_department]', with: artwork.uc_department)
    fill_in('artwork[work_title]', with: artwork.work_title)
    fill_in('artwork[other_title]', with: artwork.other_title)
    fill_in('artwork[location]', with: artwork.location)
    fill_in('artwork[date]', with: artwork.date)
    click_on('Submit')

    expect(page).to have_current_path(Rails.application.routes.url_helpers.publications_path)

    # Check values
    expect(page).to have_text 'First Last'
    expect(page).to have_text 'Second None'
    expect(page).to have_text 'Arts and Sciences'
    expect(page).to have_text 'Department'
    expect(page).to have_text 'Title'
    expect(page).not_to have_text 'Subtitle'
    expect(page).not_to have_text 'Location'
    expect(page).not_to have_text 'Date'
  end
end
