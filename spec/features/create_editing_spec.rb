# frozen_string_literal: true

require 'rails_helper'

describe 'Create a Editing', :feature, js: true do
  let(:submitter) { FactoryBot.build(:submitter) }
  let(:editing) { FactoryBot.build(:editing) }

  it 'from publications index page' do
    create_submitter(submitter)
    visit publications_path
    find(:xpath, "//a[@href='#{Rails.application.routes.url_helpers.new_editing_path}']").click

    # New Editing Page
    expect(page).to have_current_path(Rails.application.routes.url_helpers.new_editing_path)
    (0..editing.author_first_name.count - 1).each do |i|
      click_on('Add Author') if i != 0
      all(:xpath, "//input[@name='editing[author_first_name][]']").last.set(editing.author_first_name[i])
      all(:xpath, "//input[@name='editing[author_last_name][]']").last.set(editing.author_last_name[i])
    end
    (0..editing.college_ids.count - 1).each do |i|
      check "college_#{editing.college_ids[i]}"
    end
    fill_in('editing[uc_department]', with: editing.uc_department)
    fill_in('editing[work_title]', with: editing.work_title)
    fill_in('editing[other_title]', with: editing.other_title)
    fill_in('editing[volume]', with: editing.volume)
    fill_in('editing[issue]', with: editing.issue)
    fill_in('editing[publisher]', with: editing.publisher)
    fill_in('editing[city]', with: editing.city)
    fill_in('editing[publication_date]', with: editing.publication_date)
    fill_in('editing[url]', with: editing.url)
    fill_in('editing[doi]', with: editing.doi)
    click_on('Submit')

    expect(page).to have_current_path(Rails.application.routes.url_helpers.publications_path)

    # Check values
    expect(page).to have_text 'First Last'
    expect(page).to have_text 'Second None'
    expect(page).to have_text 'Arts and Sciences'
    expect(page).to have_text 'Department'
    expect(page).to have_text 'Title'
    expect(page).not_to have_text 'Subtitle'
    expect(page).not_to have_text 'Volume'
    expect(page).not_to have_text 'Issue'
    expect(page).not_to have_text 'Page Numbers'
    expect(page).not_to have_text 'Publisher'
    expect(page).not_to have_text 'City'
    expect(page).not_to have_text 'Publication Date'
    expect(page).not_to have_text 'URL'
    expect(page).not_to have_text 'DOI'
  end
end
