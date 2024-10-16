# frozen_string_literal: true

require 'rails_helper'

describe 'Selecting Colleges for an Artwork', :feature, js: true do
  let(:submitter) { FactoryBot.build(:submitter) }
  let(:artwork) { FactoryBot.build(:artwork) }

  context 'from Artwork creation page' do
    before do
      create_submitter(submitter)
      visit new_artwork_path
      expect(page).to have_selector('input[name="artwork[author_first_name][]"]') # Wait for the page to load
      fill_in('artwork[author_first_name][]', with: artwork.author_first_name[0])
      fill_in('artwork[author_last_name][]', with: artwork.author_last_name[0])
      fill_in('artwork[work_title]', with: artwork.work_title)
    end

    it 'selects an already listed college' do
      within '#colleges-group' do
        # Find and explicitly check the second checkbox
        checkbox = all('input[type="checkbox"]')[1]
        checkbox.set(true)

        # Explicitly wait for the checkbox to be checked
        expect(checkbox).to be_checked
      end
      click_on('Submit')

      expect(page).to have_current_path(Rails.application.routes.url_helpers.publications_path)
      # Click on the title of the newly created artwork
      click_on(artwork.work_title)
      expect(page).to have_text 'Arts and Sciences'
    end

    context 'When selecting Other college' do
      it 'toggles the Other College text field' do
        other_checkbox = all('input[type="checkbox"]').last

        # Initially, the Other College field should not be visible
        expect(page).to have_selector('#other_college_group', visible: false)

        # Select the Other checkbox
        other_checkbox.set(true)

        # Now, the Other College field should be visible
        expect(page).to have_selector('#other_college_group', visible: true)

        # Unselect the Other checkbox
        other_checkbox.set(false)

        # The Other College field should not be visible again
        expect(page).to have_selector('#other_college_group', visible: false)
      end

      it 'allows user to select Other college without filling in the Other name' do
        # The "Other" college is the last checkbox in the Colleges group
        within '#colleges-group' do
          # Find and explicitly check the last checkbox
          checkbox = all('input[type="checkbox"]').last
          checkbox.set(true)

          # Explicitly wait for the last checkbox to be checked
          expect(checkbox).to be_checked
        end

        click_on('Submit')

        expect(page).to have_current_path(Rails.application.routes.url_helpers.publications_path)
        click_on(artwork.work_title)
        expect(page).to have_text 'Other:'
      end

      it 'remembers the typed in Other College when the Other checkbox is unchecked' do
        within '#colleges-group' do
          all('input[type="checkbox"]').last.set(true)
        end
        expect(page).to have_selector('input[type="checkbox"]:checked', count: 1)

        fill_in('artwork[other_college]', with: 'Other College Name')

        within '#colleges-group' do
          all('input[type="checkbox"]').last.set(false)
        end
        expect(page).to have_selector('input[type="checkbox"]:checked', count: 0)
        expect(page).to_not have_text('Other College')

        within '#colleges-group' do
          all('input[type="checkbox"]').last.set(true)
        end
        expect(page).to have_selector('input[type="checkbox"]:checked', count: 1)
        expect(page).to have_field('Other College', with: 'Other College Name')
      end

      it 'does not save a typed in Other College if the Other checkbox is unchecked' do
        within '#colleges-group' do
          all('input[type="checkbox"]').last.set(true)
        end
        expect(page).to have_selector('input[type="checkbox"]:checked', count: 1)

        fill_in('artwork[other_college]', with: 'Other College Name')

        within '#colleges-group' do
          all('input[type="checkbox"]').last.set(false)
        end
        expect(page).to have_selector('input[type="checkbox"]:checked', count: 0)
        expect(page).to_not have_text('Other College')

        click_on('Submit')
        expect(page).to have_text('Instructions')
        expect(page).to have_current_path(Rails.application.routes.url_helpers.publications_path)
        click_on(artwork.work_title)
        expect(page).to have_text 'Show Artwork'
        expect(page).to_not have_text 'Other College Name'
      end

      it 'saves both a listed college and Other college when selected' do
        within '#colleges-group' do
          # Select the second checkbox and set it to true
          checkbox1 = all('input[type="checkbox"]')[1]
          checkbox1.set(true)

          # Explicitly wait for the checkbox to be checked
          expect(checkbox1).to be_checked

          # Select the last checkbox and set it to true
          checkbox2 = all('input[type="checkbox"]').last
          checkbox2.set(true)

          # Explicitly wait for the last checkbox to be checked
          expect(checkbox2).to be_checked
        end

        # Ensure there are exactly 2 checkboxes checked
        expect(page).to have_selector('input[type="checkbox"]:checked', count: 2)
        fill_in('artwork[other_college]', with: 'Other College Name')
        click_on('Submit')

        expect(page).to have_text('Instructions')
        expect(page).to have_current_path(Rails.application.routes.url_helpers.publications_path)
        click_on(artwork.work_title)
        expect(page).to have_text 'Show Artwork'
        expect(page).to have_text 'Arts and Sciences'
        expect(page).to have_text 'Other College Name'
      end
    end
  end
end
