# frozen_string_literal: true

require 'rails_helper'

describe 'Create a physical_medium', :feature, js: true do
  let(:submitter) { FactoryBot.build(:submitter) }
  let(:physical_medium) { FactoryBot.build(:physical_medium) }

  it 'from publications index page' do
    create_submitter(submitter)
    visit publications_path
    find(:xpath, "//a[@href='#{Rails.application.routes.url_helpers.new_physical_medium_path}']").click

    # New physical_medium Page
    expect(page).to have_current_path(Rails.application.routes.url_helpers.new_physical_medium_path)
    (0..physical_medium.author_first_name.count - 1).each do |i|
      click_on('Add Author') if i != 0
      all(:xpath, "//input[@name='physical_medium[author_first_name][]']").last.set(physical_medium.author_first_name[i])
      all(:xpath, "//input[@name='physical_medium[author_last_name][]']").last.set(physical_medium.author_last_name[i])
    end
    (0..physical_medium.college_ids.count - 1).each do |i|
      check "physical_medium_college_ids_#{physical_medium.college_ids[i]}"
    end
    fill_in('physical_medium[uc_department]', with: physical_medium.uc_department)
    fill_in('physical_medium[work_title]', with: physical_medium.work_title)
    fill_in('physical_medium[other_title]', with: physical_medium.other_title)
    fill_in('physical_medium[publisher]', with: physical_medium.publisher)
    fill_in('physical_medium[city]', with: physical_medium.city)
    fill_in('physical_medium[publication_date]', with: physical_medium.publication_date)
    fill_in('physical_medium[url]', with: physical_medium.url)
    fill_in('physical_medium[doi]', with: physical_medium.doi)
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
