# frozen_string_literal: true

require 'rails_helper'

describe 'Selecting Colleges for an Artwork', :feature, js: true do
  let(:submitter) { FactoryBot.build(:submitter) }
  let(:artwork) { FactoryBot.build(:artwork) }

  context 'from Artwork creation page' do
    before do
      create_submitter(submitter)
      visit new_artwork_path
      fill_in("artwork[author_first_name][]", with: artwork.author_first_name[0])
      fill_in("artwork[author_last_name][]", with: artwork.author_last_name[0])
      fill_in("artwork[work_title]", with: artwork.work_title)
    end

    it 'selects an already listed college' do
      within '#colleges-group' do
        all('input[type="checkbox"]')[1].set(true) # Array is zero-indexed
      end
      expect(page).to have_selector('input[type="checkbox"]:checked', count: 1)
      click_on('Submit')

      expect(page).to have_current_path(Rails.application.routes.url_helpers.publications_path)
      # Click on the title of the newly created artwork
      click_on(artwork.work_title)
      expect(page).to have_text 'Arts and Sciences'
    end

    context 'When selecting Other college' do
      it 'toggles the Other College text field' do
        other_checkbox = all('input[type="checkbox"]').last
        other_college_field = find('#other_college_group', visible: :all) # Finds even if invisible

        # Initially, the Other College field should not be visible
        expect(other_college_field).not_to be_visible

        # Select the Other checkbox
        other_checkbox.set(true)

        # Now, the Other College field should be visible
        expect(other_college_field).to be_visible

        # Unselect the Other checkbox
        other_checkbox.set(false)

        # The Other College field should not be visible again
        expect(other_college_field).not_to be_visible
      end

      it 'allows user to select Other college without filling in the Other name' do
        # The "Other" college is the last checkbox in the Colleges group
        within '#colleges-group' do
          all('input[type="checkbox"]').last.set(true)
        end

        expect(page).to have_selector('input[type="checkbox"]:checked', count: 1)
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

        expect(page).to have_current_path(Rails.application.routes.url_helpers.publications_path)
        click_on(artwork.work_title)
        expect(page).to_not have_text 'Other College Name'
      end

      it 'saves both a listed college and Other college when selected' do
        within '#colleges-group' do
          all('input[type="checkbox"]')[1].set(true) # Array is zero-indexed
          all('input[type="checkbox"]').last.set(true)
        end
        expect(page).to have_selector('input[type="checkbox"]:checked', count: 2)
        fill_in('artwork[other_college]', with: 'Other College Name')
        click_on('Submit')

        expect(page).to have_current_path(Rails.application.routes.url_helpers.publications_path)
        click_on(artwork.work_title)
        expect(page).to have_text 'Arts and Sciences'
        expect(page).to have_text 'Other College Name'
      end
    end
  end
end
