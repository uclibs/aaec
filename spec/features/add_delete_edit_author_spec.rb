# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Author Addition, Removal, and Editing in Publications', type: :feature, js: true do
  let(:submitter) { FactoryBot.create(:submitter) }
  let(:other_publication) { FactoryBot.create(:other_publication, work_title: 'Author Testing Title', submitter_id: submitter.id) }
  let(:author_first_name) { 'other_publication[author_first_name][]' }
  let(:author_last_name) { 'other_publication[author_last_name][]' }

  def remove_author_at_index(index)
    within(first_name_fields[index].ancestor('div.form-row')) do
      find('button', text: 'Remove Author').click
    end
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
    expect(first_name_fields[0].value).to be_empty
    expect(last_name_fields[0].value).to be_empty

    # Fill out the fields with the first author's name
    fill_in author_first_name, with: other_publication.author_first_name.first
    fill_in author_last_name, with: other_publication.author_last_name.first

    # Click "Add Author" and verify new fields
    click_on 'Add Author'
    expect(first_name_fields.size).to eq(2)
    expect(last_name_fields.size).to eq(2)

    # Fill in second author's name
    first_name_fields.last.set(other_publication.author_first_name.second)
    last_name_fields.last.set(other_publication.author_last_name.second)

    # Click "Add Author" again
    click_on 'Add Author'
    expect(first_name_fields.size).to eq(3)
    expect(last_name_fields.size).to eq(3)

    # Verify that the third set of author fields is blank
    expect(first_name_fields[2].value).to be_empty
    expect(last_name_fields[2].value).to be_empty

    # Click "Remove Author" for the second author
    remove_author_at_index(1)

    # Verify that the third set of author fields is now gone
    expect(first_name_fields.size).to eq(2)
    expect(last_name_fields.size).to eq(2)

    # Verify that the second author's name is now blank
    expect(first_name_fields[1].value).to be_empty
    expect(last_name_fields[1].value).to be_empty

    # Verify that the first author's name is still present
    expect(first_name_fields[0].value).to eq(other_publication.author_first_name.first)
    expect(last_name_fields[0].value).to eq(other_publication.author_last_name.first)

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

    # Remove the 'third' author
    remove_author_at_index(1)

    # Remove the 'fourth' author
    remove_author_at_index(1)

    # Verify that there are now only 2 authors
    expect(first_name_fields.size).to eq(2)
    expect(last_name_fields.size).to eq(2)

    # Verify that the first author's name is still present
    expect(first_name_fields[0].value).to eq(other_publication.author_first_name.first)
    expect(last_name_fields[0].value).to eq(other_publication.author_last_name.first)

    # Verify that the last author's name is now the 'fifth' author's name
    expect(first_name_fields[1].value).to eq('FifthFirstName')
    expect(last_name_fields[1].value).to eq('FifthLastName')

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
    expect(page).to have_content('FifthFirstName FifthLastName')

    # Click the edit button
    click_on 'Edit'

    # Add a 'sixth' and 'seventh' author
    expect(page).to have_content('Editing Other Publication')
    click_on 'Add Author'
    expect(first_name_fields.size).to eq(3)
    expect(last_name_fields.size).to eq(3)
    first_name_fields.last.set('SixthFirstName')
    last_name_fields.last.set('SixthLastName')
    click_on 'Add Author'
    expect(first_name_fields.size).to eq(4)
    expect(last_name_fields.size).to eq(4)
    first_name_fields.last.set('SeventhFirstName')
    last_name_fields.last.set('SeventhLastName')

    # Remove the 'sixth' author at index 2
    remove_author_at_index(2)

    # Verify that we have three authors
    expect(first_name_fields.size).to eq(3)
    expect(last_name_fields.size).to eq(3)

    # Verify that all authors names are correct:
    expect(first_name_fields[0].value).to eq(other_publication.author_first_name.first)
    expect(last_name_fields[0].value).to eq(other_publication.author_last_name.first)
    expect(first_name_fields[1].value).to eq('FifthFirstName')
    expect(last_name_fields[1].value).to eq('FifthLastName')
    expect(first_name_fields[2].value).to eq('SeventhFirstName')
    expect(last_name_fields[2].value).to eq('SeventhLastName')

    # Modify the 'fifth' author's name
    first_name_fields[1].set('FifthFirstNameModified')
    last_name_fields[1].set('FifthLastNameModified')

    # Save the changes
    click_on 'Submit'

    # Verify the authors on the publications page
    expect(page).to have_content('Show Other Publication')
    expect(page).to have_content('OtherPublication was successfully updated.')
    expect(page).to have_content(other_publication.author_first_name.first)
    expect(page).to have_content(other_publication.author_last_name.first)
    expect(page).to have_content('FifthFirstNameModified')
    expect(page).to have_content('FifthLastNameModified')
    expect(page).to have_content('SeventhFirstName')
    expect(page).to have_content('SeventhLastName')
  end
end
