# frozen_string_literal: true

require 'rails_helper'

describe 'Create a public_performance', :feature, js: true do
  let(:submitter) { FactoryBot.build(:submitter) }
  let(:public_performance) { FactoryBot.build(:public_performance) }

  it 'from publications index page' do
    create_submitter(submitter)
    visit publications_path
    find(:xpath, "//a[@href='#{Rails.application.routes.url_helpers.new_public_performance_path}']").click

    # New public_performance Page
    expect(page).to have_current_path(Rails.application.routes.url_helpers.new_public_performance_path)
    (0..public_performance.author_first_name.count - 1).each do |i|
      click_on('Add Author') if i != 0
      all(:xpath, "//input[@name='public_performance[author_first_name][]']").last.set(public_performance.author_first_name[i])
      all(:xpath, "//input[@name='public_performance[author_last_name][]']").last.set(public_performance.author_last_name[i])
    end
    (0..public_performance.college_ids.count - 1).each do |i|
      check "college_#{public_performance.college_ids[i]}"
    end
    fill_in('public_performance[uc_department]', with: public_performance.uc_department)
    fill_in('public_performance[work_title]', with: public_performance.work_title)
    fill_in('public_performance[other_title]', with: public_performance.other_title)
    fill_in('public_performance[location]', with: public_performance.location)
    fill_in('public_performance[date]', with: public_performance.date)
    fill_in('public_performance[time]', with: public_performance.time)
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
    expect(page).not_to have_text 'Time'
  end
end
