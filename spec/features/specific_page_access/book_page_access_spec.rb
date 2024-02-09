# frozen_string_literal: true

# We are verifying the access to a book's view and edit pages.,

# The application is within open dates.
# The user has a valid authentication token.
# The user is logged in as either a submitter or admin
require 'rails_helper'

RSpec.describe 'Book Submission Ownership', type: :feature do
  let(:submitter) { FactoryBot.create(:submitter) }
  let(:another_submitter) { FactoryBot.create(:submitter) }

  before do
    submitter
    another_submitter
  end

  context 'when admin is logged in' do
    before do
      login_as_admin
      create_book_as_new_submitter
      click_on("I'm Finished")
    end

    it 'allows access to the book view page' do
      visit book_path(Book.first.id)
      expect(page).to have_http_status(:ok)
    end

    it 'allows access to the book edit page' do
      visit edit_book_path(Book.first.id)
      expect(page).to have_http_status(:ok)
    end
  end

  context 'when submitter owns the resource' do
    before do
      create_book_as_new_submitter
    end

    it 'allows access to the book show page' do
      visit book_path(Book.first.id)
      expect(page).to have_http_status(:ok)
    end

    it 'allows access to the edit book page' do
      visit edit_book_path(Book.first.id)
      expect(page).to have_http_status(:ok)
    end
  end

  context 'when another submitter is logged in' do
    before do
      create_book_as_new_submitter
      click_on("I'm Finished")
      create_submitter(another_submitter)
    end

    it 'restricts access to the book view page' do
      expect { visit book_path(Book.first.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'restricts access to the book edit page' do
      expect { visit edit_book_path(Book.first.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  def create_book_as_new_submitter
    create_submitter(submitter)
    visit new_book_path
    fill_in('book[work_title]', with: 'The History of Unicorns')
    fill_in('book[author_first_name][]', with: 'Juan')
    fill_in('book[author_last_name][]', with: 'Dela Cruz')
    click_on('Submit')
  end
end
