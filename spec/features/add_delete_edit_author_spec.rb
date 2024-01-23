# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Author Addition, Removal, and Editing in Publications', type: :feature, js: true do
  let(:submitter) { FactoryBot.create(:submitter) }
  let(:other_publication) { FactoryBot.create(:other_publication, work_title: 'Author Testing Title', submitter_id: submitter.id) }
  let(:author_first_name) { 'other_publication[author_first_name][]' }
  let(:author_last_name) { 'other_publication[author_last_name][]' }

  def remove_author_at_index(index)
    # Find the first name field at the given index
    first_name_field = first_name_fields[index]

    # Navigate two levels up from the found field to reach the intended parent element
    parent_element = first_name_field.find(:xpath, '../..')

    # Within the parent element, find and click the "Remove Author" button
    within(parent_element) do
      # Find the button using Capybara
      # Find the button using Capybara
      my_button = find('button', text: 'Remove Author')

      # Assign a unique ID to the element
      unique_id = 'unique-button-id'
      page.execute_script("arguments[0].id = '#{unique_id}'", my_button)

      # Execute the script to change the button's background color using the unique ID
      page.execute_script("document.getElementById('#{unique_id}').innerHTML = 'green';")
      page.save_screenshot(Rails.root.join('tmp', 'screenshots', 'after-turning-green.png'))
      find('button', text: 'green').click
    end
  end

  def check_field_values_by_index(index, first_name, last_name)
    expect(first_name_fields[index].value).to eq(first_name)
    expect(last_name_fields[index].value).to eq(last_name)
  end

  # Defined as a method to avoid stale element errors
  def first_name_fields
    all("input[name=\"#{author_first_name}\"]")
  end

  # Defined as a method to avoid stale element errors
  def last_name_fields
    all("input[name=\"#{author_last_name}\"]")
  end

  scenario 'Add, delete, edit, and verify other publications' do
    create_submitter(submitter)
    visit new_other_publication_path
    expect(page).to have_current_path(Rails.application.routes.url_helpers.new_other_publication_path)

    # Verify blank input fields for author's first name and last name
    # to be present on page load
    expect(first_name_fields.size).to eq(1)
    expect(last_name_fields.size).to eq(1)
    check_field_values_by_index(0, '', '')

    # Fill out the fields with the first author's name
    fill_in author_first_name, with: other_publication.author_first_name.first
    fill_in author_last_name, with: other_publication.author_last_name.first

    # Click "Add Author" and verify new and old fields
    click_on 'Add Author'
    expect(first_name_fields.size).to eq(2)
    expect(last_name_fields.size).to eq(2)
    check_field_values_by_index(0, other_publication.author_first_name.first, other_publication.author_last_name.first)
    check_field_values_by_index(1, '', '')

    # Fill in second author's name
    first_name_fields.last.set(other_publication.author_first_name.second)
    last_name_fields.last.set(other_publication.author_last_name.second)

    # Click "Add Author" again
    click_on 'Add Author'
    expect(first_name_fields.size).to eq(3)
    expect(last_name_fields.size).to eq(3)

    # Verify that the third set of author fields is blank
    # and that the first two sets of author fields are still present
    expect(first_name_fields[2].value).to be_empty
    expect(last_name_fields[2].value).to be_empty
    check_field_values_by_index(0, other_publication.author_first_name.first, other_publication.author_last_name.first)
    check_field_values_by_index(1, other_publication.author_first_name.second, other_publication.author_last_name.second)

    # Click "Remove Author" for the second author
    remove_author_at_index(1)

    # Verify that the second set of author fields is now gone
    # and that the other two sets of author fields are still present
    expect(first_name_fields.size).to eq(2)
    expect(last_name_fields.size).to eq(2)
    check_field_values_by_index(0, other_publication.author_first_name.first, other_publication.author_last_name.first)
    check_field_values_by_index(1, '', '')

    # Fill in third author's name
    first_name_fields.last.set('ThirdFirstName')
    last_name_fields.last.set('ThirdLastName')

    # Add fourth and fifth authors
    click_on 'Add Author'
    first_name_fields.last.set('FourthFirstName')
    last_name_fields.last.set('FourthLastName')
    click_on 'Add Author'
    first_name_fields.last.set('FifthFirstName')
    last_name_fields.last.set('FifthLastName')

    # Remove the 'third' author (at index 1)
    remove_author_at_index(1)

    # Verify that there are now only 3 authors
    # and that they have the correct names
    expect(first_name_fields.size).to eq(3)
    expect(last_name_fields.size).to eq(3)
    check_field_values_by_index(0, other_publication.author_first_name.first, other_publication.author_last_name.first)
    check_field_values_by_index(1, 'FourthFirstName', 'FourthLastName')
    check_field_values_by_index(2, 'FifthFirstName', 'FifthLastName')

    # Remove the 'fifth' author (at index 2)

    page.save_screenshot(Rails.root.join('tmp', 'screenshots', 'before-removing-index-2.png'))
    remove_author_at_index(2)
    page.save_screenshot(Rails.root.join('tmp', 'screenshots', 'after-removing-index-2.png'))
    # Verify that there are now only 2 authors
    # and that they have the correct names
    expect(first_name_fields.size).to eq(2)
    expect(last_name_fields.size).to eq(2)
    check_field_values_by_index(0, other_publication.author_first_name.first, other_publication.author_last_name.first)
    check_field_values_by_index(1, 'FourthFirstName', 'FourthLastName')

    # Add a sixth author
    click_on 'Add Author'
    first_name_fields.last.set('SixthFirstName')
    last_name_fields.last.set('SixthLastName')

    # Click "Remove Author" for the sixth author (at index 2)
    remove_author_at_index(2) # 2 because we have 3 authors now (after previous deletions), but the index is 0-based

    # Verify that there are now only 2 authors
    # and that they have the correct names
    expect(first_name_fields.size).to eq(2)
    expect(last_name_fields.size).to eq(2)
    check_field_values_by_index(0, other_publication.author_first_name.first, other_publication.author_last_name.first)
    check_field_values_by_index(1, 'FourthFirstName', 'FourthLastName')

    # At this point, we have two authors - the first and the "fourth" author.

    # Fill in the other required field(s)
    fill_in 'other_publication[work_title]', with: other_publication.work_title

    # Submit the form
    click_on 'Submit'

    # Wait for the page to load and then check the current path
    expect(page).to have_current_path(publications_path)

    # Verify that the publication is listed on the publications page
    expect(page).to have_content(other_publication.work_title)

    # Navigate to the show page via clicking on the title of the newly created publication
    find('a', text: other_publication.work_title.to_s).click
    expect(page).to have_content('Show Other Publication')

    # Verify that the authors are correct
    expect(page).to have_content("#{other_publication.author_first_name.first} #{other_publication.author_last_name.first}")
    expect(page).to have_content('FourthFirstName FourthLastName')

    # Click the edit button
    click_on 'Edit'

    # Add a 'sixth' and 'seventh' author
    expect(page).to have_content('Editing Other Publication')
    click_on 'Add Author'
    expect(first_name_fields.size).to eq(3)
    expect(last_name_fields.size).to eq(3)
    first_name_fields.last.set('SeventhFirstName')
    last_name_fields.last.set('SeventhLastName')
    click_on 'Add Author'
    expect(first_name_fields.size).to eq(4)
    expect(last_name_fields.size).to eq(4)
    first_name_fields.last.set('EighthFirstName')
    last_name_fields.last.set('EighthLastName')

    # Remove the 'eighth' author at index 3
    remove_author_at_index(3)

    # Verify that we have three authors
    # and that they have the correct names
    expect(first_name_fields.size).to eq(3)
    expect(last_name_fields.size).to eq(3)
    check_field_values_by_index(0, other_publication.author_first_name.first, other_publication.author_last_name.first)
    check_field_values_by_index(1, 'FourthFirstName', 'FourthLastName')
    check_field_values_by_index(2, 'SeventhFirstName', 'SeventhLastName')

    # Modify the 'fifth' author's name
    first_name_fields[1].set('FourthFirstNameModified')
    last_name_fields[1].set('FourthLastNameModified')

    # Save the changes
    click_on 'Submit'

    # Verify the authors on the publications page
    expect(page).to have_content('Show Other Publication')
    expect(page).to have_content('OtherPublication was successfully updated.')
    expect(page).to have_content(other_publication.author_first_name.first)
    expect(page).to have_content(other_publication.author_last_name.first)
    expect(page).to have_content('FourthFirstNameModified')
    expect(page).to have_content('FourthLastNameModified')
    expect(page).to have_content('SeventhFirstName')
    expect(page).to have_content('SeventhLastName')
  end
end
