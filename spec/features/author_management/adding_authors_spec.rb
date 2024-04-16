# frozen_string_literal: true

require 'rails_helper'

describe 'Adding Authors', :feature, js: true do
  let(:submitter) { FactoryBot.create(:submitter) }
  let(:other_publication) { FactoryBot.create(:other_publication, author_first_name: ['First0'], author_last_name: ['Last0'], submitter_id: submitter.id) }
  let(:pub_id) { other_publication.id }

  before do
    create_submitter(submitter)
  end

  it 'adds authors to a new publication' do
    visit new_other_publication_path

    # Verify blank input fields for author's first name and last name
    # to be present on page load
    expect(page).to have_selector("input[name='other_publication[author_first_name][]']", count: 1)
    expect(page).to have_selector("input[name='other_publication[author_last_name][]']", count: 1)
    check_field_values_by_index(0, '', '')

    first_name_fields.last.set('First0')
    last_name_fields.last.set('Last0')

    add_author_or_artist_and_verify_field

    check_field_values_by_index(0, 'First0', 'Last0')
    check_field_values_by_index(1, '', '')

    first_name_fields.last.set('First1')
    last_name_fields.last.set('Last1')

    add_author_or_artist_and_verify_field

    check_field_values_by_index(0, 'First0', 'Last0')
    check_field_values_by_index(1, 'First1', 'Last1')
    check_field_values_by_index(2, '', '')

    first_name_fields.last.set('First2')
    last_name_fields.last.set('Last2')

    add_author_or_artist_and_verify_field

    check_field_values_by_index(0, 'First0', 'Last0')
    check_field_values_by_index(1, 'First1', 'Last1')
    check_field_values_by_index(2, 'First2', 'Last2')
    check_field_values_by_index(3, '', '')

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
    expect(page).to have_text 'Other Publication was successfully created.'
    expect(page).to have_current_path(Rails.application.routes.url_helpers.publications_path)

    # Check the last other_publication and verify that the author names are correct
    last_other_publication = OtherPublication.last
    expect(last_other_publication.author_first_name).to eq %w[First0 First1 First2 First3]
    expect(last_other_publication.author_last_name).to eq %w[Last0 Last1 Last2 Last3]
  end

  it 'adds authors to an existing publication' do
    login_as_admin_feature_test

    visit edit_other_publication_path(pub_id)
    expect(page).to have_selector("input[name='other_publication[author_first_name][]']", count: 1)

    # Defined with the factory creation above
    check_field_values_by_index(0, 'First0', 'Last0')

    add_author_or_artist_and_verify_field

    first_name_fields.last.set('First1')
    last_name_fields.last.set('Last1')

    add_author_or_artist_and_verify_field

    check_field_values_by_index(0, 'First0', 'Last0')
    check_field_values_by_index(1, 'First1', 'Last1')

    first_name_fields.last.set('First2')
    last_name_fields.last.set('Last2')

    click_on 'Submit'
    expect(page).to have_text 'Other Publication was successfully updated.'

    other_publication = OtherPublication.find(pub_id)
    other_publication.reload

    expect(other_publication.author_first_name).to eq %w[First0 First1 First2]
    expect(other_publication.author_last_name).to eq %w[Last0 Last1 Last2]
  end
end
