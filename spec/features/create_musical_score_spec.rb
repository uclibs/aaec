# frozen_string_literal: true

require 'rails_helper'

describe 'Create a musical_score', :feature, js: true do
  let(:submitter) { FactoryBot.build(:submitter) }
  let(:musical_score) { FactoryBot.build(:musical_score) }

  it 'from publications index page' do
    create_submitter(submitter)
    visit publications_path
    find(:xpath, "//a[@href='#{Rails.application.routes.url_helpers.new_musical_score_path}']").click

    # New musical_score Page
    expect(page).to have_current_path(Rails.application.routes.url_helpers.new_musical_score_path)
    (0..musical_score.author_first_name.count - 1).each do |i|
      click_on('Add Author') if i != 0
      all(:xpath, "//input[@name='musical_score[author_first_name][]']").last.set(musical_score.author_first_name[i])
      all(:xpath, "//input[@name='musical_score[author_last_name][]']").last.set(musical_score.author_last_name[i])
    end
    (0..musical_score.college_ids.count - 1).each do |i|
      check "college_#{musical_score.college_ids[i]}"
    end
    fill_in('musical_score[uc_department]', with: musical_score.uc_department)
    fill_in('musical_score[work_title]', with: musical_score.work_title)
    fill_in('musical_score[other_title]', with: musical_score.other_title)
    fill_in('musical_score[publisher]', with: musical_score.publisher)
    fill_in('musical_score[city]', with: musical_score.city)
    fill_in('musical_score[publication_date]', with: musical_score.publication_date)
    fill_in('musical_score[url]', with: musical_score.url)
    fill_in('musical_score[doi]', with: musical_score.doi)
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
