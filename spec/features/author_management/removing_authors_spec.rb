# frozen_string_literal: true

require 'rails_helper'

describe 'Removing Authors', :feature, js: true do
  let(:other_publication) { FactoryBot.create(:other_publication, author_first_name: %w[First0 First1 First2 First3], author_last_name: %w[Last0 Last1 Last2 Last3]) }
  let(:pub_id) { other_publication.id }

  before do
    login_as_admin_feature_test
    visit edit_other_publication_path(other_publication)
    expect(page).to have_selector("input[name='other_publication[author_first_name][]']", count: 4)
  end

  it 'removes the second author from the publication' do
    remove_author_at_index(1)
    expect(page).to have_selector("input[name='other_publication[author_first_name][]']", count: 3)
    expect(page).to have_selector("input[name='other_publication[author_last_name][]']", count: 3)
    check_field_values_by_index(0, 'First0', 'Last0')
    check_field_values_by_index(1, 'First2', 'Last2')
    check_field_values_by_index(2, 'First3', 'Last3')

    # Remove the second author again (should be "First2")
    remove_author_at_index(1)
    expect(page).to have_selector("input[name='other_publication[author_first_name][]']", count: 2)
    expect(page).to have_selector("input[name='other_publication[author_last_name][]']", count: 2)
    check_field_values_by_index(0, 'First0', 'Last0')
    check_field_values_by_index(1, 'First3', 'Last3')

    # Remove the second author again (should be "First3")
    remove_author_at_index(1)
    expect(page).to have_selector("input[name='other_publication[author_first_name][]']", count: 1)
    expect(page).to have_selector("input[name='other_publication[author_last_name][]']", count: 1)
    check_field_values_by_index(0, 'First0', 'Last0')
  end

  it 'removes the last author from the publication' do
    remove_author_at_index(3)
    expect(page).to have_selector("input[name='other_publication[author_first_name][]']", count: 3)
    expect(page).to have_selector("input[name='other_publication[author_last_name][]']", count: 3)
    check_field_values_by_index(0, 'First0', 'Last0')
    check_field_values_by_index(1, 'First1', 'Last1')
    check_field_values_by_index(2, 'First2', 'Last2')

    remove_author_at_index(2)
    expect(page).to have_selector("input[name='other_publication[author_first_name][]']", count: 2)
    expect(page).to have_selector("input[name='other_publication[author_last_name][]']", count: 2)
    check_field_values_by_index(0, 'First0', 'Last0')
    check_field_values_by_index(1, 'First1', 'Last1')

    remove_author_at_index(1)
    expect(page).to have_selector("input[name='other_publication[author_first_name][]']", count: 1)
    expect(page).to have_selector("input[name='other_publication[author_last_name][]']", count: 1)
    check_field_values_by_index(0, 'First0', 'Last0')
  end

  it 'does not have a Remove Author button for the first author' do
    expect(first_author_element).not_to have_selector('button', text: 'Remove Author')
  end
end
