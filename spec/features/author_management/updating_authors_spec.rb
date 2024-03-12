# frozen_string_literal: true

require 'rails_helper'

describe 'Adding Authors', :feature, js: true do
  let(:submitter) { FactoryBot.create(:submitter) }
  let(:other_publication) { FactoryBot.create(:other_publication, author_first_name: %w[First0 First1 First2 First3], author_last_name: %w[Last0 Last1 Last2 Last3], submitter_id: submitter.id) }
  let(:pub_id) { other_publication.id }

  before do
    login_as_admin_feature_test
    visit edit_other_publication_path(pub_id)
    expect(page).to have_selector("input[name='other_publication[author_first_name][]']", count: 4)
  end

  it "allows the user to update the first author's information" do
    check_field_values_by_index(0, 'First0', 'Last0')
    check_field_values_by_index(1, 'First1', 'Last1')
    check_field_values_by_index(2, 'First2', 'Last2')
    check_field_values_by_index(3, 'First3', 'Last3')

    # Update the first author's name
    first_name_fields.first.set('First0modified')
    last_name_fields.first.set('Last0modified')
    click_on 'Submit'
    expect(page).to have_content('Show Other Publication')

    other_publication.reload

    expect(other_publication.author_first_name).to eq(%w[First0modified First1 First2 First3])
    expect(other_publication.author_last_name).to eq(%w[Last0modified Last1 Last2 Last3])
  end

  it "allows the user to update the second author's information" do
    check_field_values_by_index(0, 'First0', 'Last0')
    check_field_values_by_index(1, 'First1', 'Last1')
    check_field_values_by_index(2, 'First2', 'Last2')
    check_field_values_by_index(3, 'First3', 'Last3')

    # Update the second author's name
    first_name_fields[1].set('First1modified')
    last_name_fields[1].set('Last1modified')

    click_on 'Submit'
    expect(page).to have_content('Show Other Publication')

    other_publication.reload

    expect(other_publication.author_first_name).to eq(%w[First0 First1modified First2 First3])
  end

  it "allows the user to update the last author's information" do
    check_field_values_by_index(0, 'First0', 'Last0')
    check_field_values_by_index(1, 'First1', 'Last1')
    check_field_values_by_index(2, 'First2', 'Last2')
    check_field_values_by_index(3, 'First3', 'Last3')

    # Update the last author's name
    first_name_fields.last.set('First3modified')
    last_name_fields.last.set('Last3modified')

    click_on 'Submit'
    expect(page).to have_content('Show Other Publication')

    other_publication.reload

    expect(other_publication.author_first_name).to eq(%w[First0 First1 First2 First3modified])
    expect(other_publication.author_last_name).to eq(%w[Last0 Last1 Last2 Last3modified])
  end

  it 'persists the changes when refreshing the page' do
    check_field_values_by_index(0, 'First0', 'Last0')
    check_field_values_by_index(1, 'First1', 'Last1')
    check_field_values_by_index(2, 'First2', 'Last2')
    check_field_values_by_index(3, 'First3', 'Last3')

    first_name_fields.first.set('First0modified')
    last_name_fields.first.set('Last0modified')
    first_name_fields[1].set('First1modified')
    last_name_fields[1].set('Last1modified')
    first_name_fields[2].set('First2modified')
    last_name_fields[2].set('Last2modified')
    first_name_fields.last.set('First3modified')
    last_name_fields.last.set('Last3modified')
    click_on 'Submit'
    expect(page).to have_content('Show Other Publication')

    visit current_path
    expect(page).to have_content('Show Other Publication')

    expect(page).to have_text('First0modified Last0modified, First1modified Last1modified, First2modified Last2modified, First3modified Last3modified')
  end
end
