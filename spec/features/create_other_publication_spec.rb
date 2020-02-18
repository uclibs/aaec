# frozen_string_literal: true

require 'rails_helper'

describe 'Create a Other Publication', :feature, js: true do
  let(:submitter) { FactoryBot.build(:submitter) }
  let(:other_publication) { FactoryBot.build(:other_publication) }

  it 'from publications index page' do
    create_submitter(submitter)
    visit publications_path
    find(:xpath, "//a[@href='#{Rails.application.routes.url_helpers.new_other_publication_path}']").click

    # New Other Publication Page
    expect(page).to have_current_path(Rails.application.routes.url_helpers.new_other_publication_path)
    (0..other_publication.author_first_name.count - 1).each do |i|
      click_on('Add Author') if i != 0
      all(:xpath, "//input[@name='other_publication[author_first_name][]']").last.set(other_publication.author_first_name[i])
      all(:xpath, "//input[@name='other_publication[author_last_name][]']").last.set(other_publication.author_last_name[i])
    end
    (0..other_publication.college_ids.count - 1).each do |i|
      check "other_publication_college_ids_#{other_publication.college_ids[i]}"
    end
    fill_in('other_publication[uc_department]', with: other_publication.uc_department)
    fill_in('other_publication[work_title]', with: other_publication.work_title)
    fill_in('other_publication[other_title]', with: other_publication.other_title)
    fill_in('other_publication[volume]', with: other_publication.volume)
    fill_in('other_publication[issue]', with: other_publication.issue)
    fill_in('other_publication[page_numbers]', with: other_publication.page_numbers)
    fill_in('other_publication[publisher]', with: other_publication.publisher)
    fill_in('other_publication[city]', with: other_publication.city)
    fill_in('other_publication[publication_date]', with: other_publication.publication_date)
    fill_in('other_publication[url]', with: other_publication.url)
    fill_in('other_publication[doi]', with: other_publication.doi)
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
