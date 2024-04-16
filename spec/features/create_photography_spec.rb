# frozen_string_literal: true

require 'rails_helper'

describe 'Create a Photography', :feature, js: true do
  let(:submitter) { FactoryBot.build(:submitter) }
  let(:photography) { FactoryBot.build(:photography) }

  it 'from publications index page' do
    create_submitter(submitter)
    visit publications_path
    find(:xpath, "//a[@href='#{Rails.application.routes.url_helpers.new_photography_path}']").click

    # New photography Page
    expect(page).to have_current_path(Rails.application.routes.url_helpers.new_photography_path)
    (0..photography.author_first_name.count - 1).each do |i|
      click_on('Add Author') if i != 0
      all(:xpath, "//input[@name='photography[author_first_name][]']").last.set(photography.author_first_name[i])
      all(:xpath, "//input[@name='photography[author_last_name][]']").last.set(photography.author_last_name[i])
    end
    (0..photography.college_ids.count - 1).each do |i|
      check "photography_college_ids_#{photography.college_ids[i]}"
    end
    fill_in('photography[uc_department]', with: photography.uc_department)
    fill_in('photography[work_title]', with: photography.work_title)
    fill_in('photography[other_title]', with: photography.other_title)
    fill_in('photography[publisher]', with: photography.publisher)
    fill_in('photography[city]', with: photography.city)
    fill_in('photography[publication_date]', with: photography.publication_date)
    fill_in('photography[url]', with: photography.url)
    fill_in('photography[doi]', with: photography.doi)
    click_on('Submit')

    expect(page).to have_current_path(Rails.application.routes.url_helpers.publications_path)

    # Check values
    expect(page).to have_text 'First Last'
    expect(page).to have_text 'Second None'
    expect(page).to have_text 'Arts and Sciences'
    expect(page).to have_text 'Department'
    expect(page).to have_text 'Title'
    expect(page).not_to have_text 'Subtitle'
    expect(page).not_to have_text 'Publisher'
    expect(page).not_to have_text 'City'
    expect(page).not_to have_text 'Publication Date'
    expect(page).not_to have_text 'URL'
    expect(page).not_to have_text 'DOI'
  end
end
