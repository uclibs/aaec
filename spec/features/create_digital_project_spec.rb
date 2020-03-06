# frozen_string_literal: true

require 'rails_helper'

describe 'Create a digital_project', :feature, js: true do
  let(:submitter) { FactoryBot.build(:submitter) }
  let(:digital_project) { FactoryBot.build(:digital_project) }

  it 'from publications index page' do
    create_submitter(submitter)
    visit publications_path
    find(:xpath, "//a[@href='#{Rails.application.routes.url_helpers.new_digital_project_path}']").click

    # New digital_project Page
    expect(page).to have_current_path(Rails.application.routes.url_helpers.new_digital_project_path)
    (0..digital_project.author_first_name.count - 1).each do |i|
      click_on('Add Author') if i != 0
      all(:xpath, "//input[@name='digital_project[author_first_name][]']").last.set(digital_project.author_first_name[i])
      all(:xpath, "//input[@name='digital_project[author_last_name][]']").last.set(digital_project.author_last_name[i])
    end
    (0..digital_project.college_ids.count - 1).each do |i|
      check "digital_project_college_ids_#{digital_project.college_ids[i]}"
    end
    fill_in('digital_project[uc_department]', with: digital_project.uc_department)
    fill_in('digital_project[work_title]', with: digital_project.work_title)
    fill_in('digital_project[other_title]', with: digital_project.other_title)
    fill_in('digital_project[name_of_site]', with: digital_project.name_of_site)
    fill_in('digital_project[name_of_affiliated_organization]', with: digital_project.name_of_affiliated_organization)
    fill_in('digital_project[version]', with: digital_project.version)
    fill_in('digital_project[publication_date]', with: digital_project.publication_date)
    fill_in('digital_project[url]', with: digital_project.url)
    fill_in('digital_project[doi]', with: digital_project.doi)
    click_on('Submit')

    expect(page).to have_current_path(Rails.application.routes.url_helpers.publications_path)

    # Check values
    expect(page).to have_text 'First Last'
    expect(page).to have_text 'Second None'
    expect(page).to have_text 'Arts and Sciences'
    expect(page).to have_text 'Department'
    expect(page).to have_text 'Title'
    expect(page).not_to have_text 'Subtitle'
    expect(page).not_to have_text 'Name of site'
    expect(page).not_to have_text 'Name of affiliated organization'
    expect(page).not_to have_text 'Version'
    expect(page).not_to have_text 'Publication Date'
    expect(page).not_to have_text 'URL'
    expect(page).not_to have_text 'DOI'
  end
end
