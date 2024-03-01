# frozen_string_literal: true

require 'rails_helper'

describe 'Adding Authors', :feature, js: true do
  let(:submitter) { FactoryBot.create(:submitter) }

  before do
    create_submitter(submitter)
  end

  it "allows the user to update the first author's information" do
    create_other_publication
    add_three_more_authors_to_publication(OtherPublication.last)
    visit edit_other_publication_path(OtherPublication.last)
    expect(page).to have_selector("input[name='other_publication[author_first_name][]']", count: 4)
    expect(page).to have_selector("input[name='other_publication[author_last_name][]']", count: 4)
    check_field_values_by_index(0, 'First0', 'Last0')
    check_field_values_by_index(1, 'First1', 'Last1')
    check_field_values_by_index(2, 'First2', 'Last2')
    check_field_values_by_index(3, 'First3', 'Last3')

    # Update the first author's name
    first_name_fields.first.set('First0modified')
    last_name_fields.first.set('Last0modified')
    click_on 'Submit'

    expect(page).to have_current_path(other_publication_path(OtherPublication.last))
    expect(page).to have_content('First0modified')
    expect(page).to have_content('Last0modified')
    expect(page).to have_content('First1')
    expect(page).to have_content('Last1')
    expect(page).to have_content('First2')
    expect(page).to have_content('Last2')
    expect(page).to have_content('First3')
    expect(page).to have_content('Last3')
  end

  it "allows the user to update the second author's information" do
    create_other_publication
    add_three_more_authors_to_publication(OtherPublication.last)
    visit edit_other_publication_path(OtherPublication.last)
    expect(page).to have_selector("input[name='other_publication[author_first_name][]']", count: 4)
    expect(page).to have_selector("input[name='other_publication[author_last_name][]']", count: 4)
    check_field_values_by_index(0, 'First0', 'Last0')
    check_field_values_by_index(1, 'First1', 'Last1')
    check_field_values_by_index(2, 'First2', 'Last2')
    check_field_values_by_index(3, 'First3', 'Last3')

    # Update the second author's name
    first_name_fields[1].set('First1modified')
    last_name_fields[1].set('Last1modified')
    click_on 'Submit'

    expect(page).to have_current_path(other_publication_path(OtherPublication.last))
    expect(page).to have_content('First0')
    expect(page).to have_content('Last0')
    expect(page).to have_content('First1modified')
    expect(page).to have_content('Last1modified')
    expect(page).to have_content('First2')
    expect(page).to have_content('Last2')
    expect(page).to have_content('First3')
    expect(page).to have_content('Last3')
  end

  it "allows the user to update the last author's information" do
    create_other_publication
    add_three_more_authors_to_publication(OtherPublication.last)
    visit edit_other_publication_path(OtherPublication.last)
    expect(page).to have_selector("input[name='other_publication[author_first_name][]']", count: 4)
    expect(page).to have_selector("input[name='other_publication[author_last_name][]']", count: 4)
    check_field_values_by_index(0, 'First0', 'Last0')
    check_field_values_by_index(1, 'First1', 'Last1')
    check_field_values_by_index(2, 'First2', 'Last2')
    check_field_values_by_index(3, 'First3', 'Last3')

    # Update the last author's name
    first_name_fields.last.set('First3modified')
    last_name_fields.last.set('Last3modified')
    click_on 'Submit'

    expect(page).to have_current_path(other_publication_path(OtherPublication.last))
    expect(page).to have_content('First0')
    expect(page).to have_content('Last0')
    expect(page).to have_content('First1')
    expect(page).to have_content('Last1')
    expect(page).to have_content('First2')
    expect(page).to have_content('Last2')
    expect(page).to have_content('First3modified')
    expect(page).to have_content('Last3modified')
  end

  it 'persists the changes when refreshing the page' do
    create_other_publication
    add_three_more_authors_to_publication(OtherPublication.last)
    visit edit_other_publication_path(OtherPublication.last)
    expect(page).to have_selector("input[name='other_publication[author_first_name][]']", count: 4)
    expect(page).to have_selector("input[name='other_publication[author_last_name][]']", count: 4)
    check_field_values_by_index(0, 'First0', 'Last0')
    check_field_values_by_index(1, 'First1', 'Last1')
    check_field_values_by_index(2, 'First2', 'Last2')
    check_field_values_by_index(3, 'First3', 'Last3')

    # Update the first author's name
    first_name_fields.first.set('First0modified')
    last_name_fields.first.set('Last0modified')
    first_name_fields[1].set('First1modified')
    last_name_fields[1].set('Last1modified')
    first_name_fields[2].set('First2modified')
    last_name_fields[2].set('Last2modified')
    first_name_fields.last.set('First3modified')
    last_name_fields.last.set('Last3modified')
    click_on 'Submit'

    page.driver.browser.navigate.refresh
    expect(page).to have_text('First0modified Last0modified, First1modified Last1modified, First2modified Last2modified, First3modified Last3modified')
  end
end
