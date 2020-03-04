# frozen_string_literal: true

require 'rails_helper'

describe 'Create a play', :feature, js: true do
  let(:submitter) { FactoryBot.build(:submitter) }
  let(:play) { FactoryBot.build(:play) }

  it 'from publications index page' do
    create_submitter(submitter)
    visit publications_path
    find(:xpath, "//a[@href='#{Rails.application.routes.url_helpers.new_play_path}']").click

    # New play Page
    expect(page).to have_current_path(Rails.application.routes.url_helpers.new_play_path)
    (0..play.author_first_name.count - 1).each do |i|
      click_on('Add Author') if i != 0
      all(:xpath, "//input[@name='play[author_first_name][]']").last.set(play.author_first_name[i])
      all(:xpath, "//input[@name='play[author_last_name][]']").last.set(play.author_last_name[i])
    end
    (0..play.college_ids.count - 1).each do |i|
      check "play_college_ids_#{play.college_ids[i]}"
    end
    fill_in('play[uc_department]', with: play.uc_department)
    fill_in('play[work_title]', with: play.work_title)
    fill_in('play[other_title]', with: play.other_title)
    fill_in('play[publisher]', with: play.publisher)
    fill_in('play[city]', with: play.city)
    fill_in('play[publication_date]', with: play.publication_date)
    fill_in('play[url]', with: play.url)
    fill_in('play[doi]', with: play.doi)
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
