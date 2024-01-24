# frozen_string_literal: true

require 'rails_helper'

describe 'Adding Authors', :feature, js: true do
  let(:submitter) { FactoryBot.create(:submitter) }

  it 'adds authors to a new publication' do
    create_submitter(submitter)
    visit new_other_publication_path
    expect(page).to have_current_path(Rails.application.routes.url_helpers.new_other_publication_path)

    # Verify blank input fields for author's first name and last name
    # to be present on page load
    expect(page).to have_selector("input[name='other_publication[author_first_name][]']", count: 1)
    expect(page).to have_selector("input[name='other_publication[author_last_name][]']", count: 1)
    check_field_values_by_index(0, '', '')

    # Fill out the fields with the first author's name
    first_name_fields.last.set('First0')
    last_name_fields.last.set('Last0')

    # Click "Add Author" and verify new and old fields
    click_on 'Add Author'

    expect(page).to have_selector("input[name='other_publication[author_first_name][]']", count: 2)
    expect(page).to have_selector("input[name='other_publication[author_last_name][]']", count: 2)

    check_field_values_by_index(0, 'First0', 'Last0')
    check_field_values_by_index(1, '', '')

    # Fill in second author's name
    first_name_fields.last.set('First1')
    last_name_fields.last.set('Last1')

    # Click "Add Author" again
    click_on 'Add Author'
    expect(page).to have_selector("input[name='other_publication[author_first_name][]']", count: 3)
    expect(page).to have_selector("input[name='other_publication[author_last_name][]']", count: 3)
    check_field_values_by_index(0, 'First0', 'Last0')
    check_field_values_by_index(1, 'First1', 'Last1')
    check_field_values_by_index(2, '', '')

    # Fill in third author's name
    first_name_fields.last.set('First2')
    last_name_fields.last.set('Last2')

    # Click "Add Author" again
    click_on 'Add Author'
    expect(page).to have_selector("input[name='other_publication[author_first_name][]']", count: 4)
    expect(page).to have_selector("input[name='other_publication[author_last_name][]']", count: 4)
    check_field_values_by_index(0, 'First0', 'Last0')
    check_field_values_by_index(1, 'First1', 'Last1')
    check_field_values_by_index(2, 'First2', 'Last2')
    check_field_values_by_index(3, '', '')

    # Fill in fourth author's name
    first_name_fields.last.set('First3')
    last_name_fields.last.set('Last3')

    # Fill in the rest of the fields
    fill_in 'other_publication[work_title]', with: 'Title'
    fill_in 'other_publication[other_title]', with: 'Subtitle'
    fill_in 'other_publication[uc_department]', with: 'Department'
    fill_in 'other_publication[publication_date]', with: 'Date'
    fill_in 'other_publication[url]', with: 'URL'
    fill_in 'other_publication[doi]', with: 'DOI'

    # Click "Submit" and verify that we are redirected to the index page
    # and that a success message is displayed
    click_on 'Submit'
    expect(page).to have_current_path(Rails.application.routes.url_helpers.publications_path)
    expect(page).to have_text 'Other Publication was successfully created.'

    # Click on the hyperlink on the id of the newly created publication
    # and verify that the author names are correct
    click_on OtherPublication.last.work_title.to_s
    expect(page).to have_current_path(Rails.application.routes.url_helpers.other_publication_path(OtherPublication.last.id))
    expect(page).to have_text 'First0 Last0'
    expect(page).to have_text 'First1 Last1'
    expect(page).to have_text 'First2 Last2'
    expect(page).to have_text 'First3 Last3'
  end

  it 'adds authors to an existing publication' do
    created_other_publication = create_other_publication
    login_as_submitter_of(created_other_publication)

  end

  def create_other_publication
    create_submitter(submitter)
    visit new_other_publication_path
    expect(page).to have_current_path(Rails.application.routes.url_helpers.new_other_publication_path)

    # Verify blank input fields for author's first name and last name
    # to be present on page load
    expect(page).to have_selector("input[name='other_publication[author_first_name][]']", count: 1)
    expect(page).to have_selector("input[name='other_publication[author_last_name][]']", count: 1)
    check_field_values_by_index(0, '', '')

    # Fill out the fields with the first author's name
    first_name_fields.last.set('First0')
    last_name_fields.last.set('Last0')

    # Click "Add Author" and verify new and old fields
    click_on 'Add Author'

    expect(page).to have_selector("input[name='other_publication[author_first_name][]']", count: 2)
    expect(page).to have_selector("input[name='other_publication[author_last_name][]']", count: 2)

    check_field_values_by_index(0, 'First0', 'Last0')
    check_field_values_by_index(1, '', '')

    # Fill in second author's name
    first_name_fields.last.set('First1')
    last_name_fields.last.set('Last1')

    # Click "Add Author" again
    click_on 'Add Author'
    expect(page).to have_selector("input[name='other_publication[author_first_name][]']", count: 3)
    expect(page).to have_selector("input[name='other_publication[author_last_name][]']", count: 3)
    check_field_values_by_index(0, 'First0', 'Last0')
    check_field_values_by_index(1, 'First1', 'Last1')
    check_field_values_by_index(2, '', '')

    # Fill in third author's name
    first_name_fields.last.set('First2')
    last_name_fields.last.set('Last2')

    # Click "Add Author" again
    click_on 'Add Author'
    expect(page).to have_selector("input[name='other_publication[author_first_name][]']", count: 4)
    expect(page).to have_selector("input[name='other_publication[author_last_name][]']", count: 4)
    check_field_values_by_index(0, 'First0
  end
end
