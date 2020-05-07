# frozen_string_literal: true

require 'rails_helper'

describe 'Create a film', :feature, js: true do
  let(:submitter) { FactoryBot.build(:submitter) }
  let(:film) { FactoryBot.build(:film) }

  it 'from publications index page' do
    create_submitter(submitter)
    visit publications_path
    find(:xpath, "//a[@href='#{Rails.application.routes.url_helpers.new_film_path}']").click

    # New film Page
    expect(page).to have_current_path(Rails.application.routes.url_helpers.new_film_path)
    (0..film.author_first_name.count - 1).each do |i|
      click_on('Add Author') if i != 0
      all(:xpath, "//input[@name='film[author_first_name][]']").last.set(film.author_first_name[i])
      all(:xpath, "//input[@name='film[author_last_name][]']").last.set(film.author_last_name[i])
    end
    (0..film.college_ids.count - 1).each do |i|
      check "film_college_ids_#{film.college_ids[i]}"
    end
    fill_in('film[uc_department]', with: film.uc_department)
    fill_in('film[work_title]', with: film.work_title)
    fill_in('film[other_title]', with: film.other_title)
    fill_in('film[director]', with: film.director)
    fill_in('film[producer]', with: film.producer)
    fill_in('film[release_year]', with: film.release_year)
    click_on('Submit')

    expect(page).to have_current_path(Rails.application.routes.url_helpers.publications_path)

    # Check values
    expect(page).to have_text 'First Last'
    expect(page).to have_text 'Second None'
    expect(page).to have_text 'Arts and Sciences'
    expect(page).to have_text 'Department'
    expect(page).to have_text 'Title'
    expect(page).not_to have_text 'Subtitle'
    expect(page).not_to have_text 'Release year'
  end
end
