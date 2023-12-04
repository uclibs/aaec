require 'rails_helper'

RSpec.describe 'Handling of invalid authenticity token', type: :feature, js: true do
  let(:submitter) { FactoryBot.create(:submitter) }

  context 'when trying to log in' do
    context 'as a submitter' do
      it 'triggers an inauthentic token error and redirects to the root path' do
        visit_root_path

        # Use JavaScript to change the authenticity token to an invalid value
        page.execute_script("document.querySelector('input[name=authenticity_token]').value = 'invalid_token';")

        create_submitter(submitter)

        expect(page).to have_current_path(root_path)
        expect(page).to have_content('Your session has expired. Please log in again.')
      end
    end

    context 'as an admin' do
      before do
        allow(ENV).to receive(:fetch).and_call_original
      end

      it 'triggers an inauthentic token error and redirects to the root path' do
        visit_manage_path
        fill_in('username', with: ENV['ADMIN_USERNAME'])
        fill_in('password', with: ENV['ADMIN_PASSWORD'])

        # Use JavaScript to change the authenticity token to an invalid value
        page.execute_script("document.querySelector('input[name=authenticity_token]').value = 'invalid_token';")

        click_on('Submit')

        expect(page).to have_current_path(root_path)
        expect(page).to have_content('Your session has expired. Please log in again.')
      end
    end
  end

  context 'when trying to visit the publications page' do
    context 'as a submitter' do
      it 'triggers an inauthentic token error and redirects to the root path' do
        visit_publications_page_as_submitter(submitter)
        # Use JavaScript to change the authenticity token to an invalid value
        page.execute_script("document.querySelector('input[name=authenticity_token]').value = 'invalid_token';")
        click_on('New')
        expect(page).to have_current_path(root_path)
        expect(page).to have_content('Your session has expired. Please log in again.')
      end
    end

    context 'as an admin' do
      it 'triggers an inauthentic token error and redirects to the root path' do
        visit_publications_page_as_admin
        # Use JavaScript to change the authenticity token to an invalid value
        page.execute_script("document.querySelector('input[name=authenticity_token]').value = 'invalid_token';")
        click_on('New')
        expect(page).to have_current_path(root_path)
        expect(page).to have_content('Your session has expired. Please log in again.')
      end
    end
  end
end
