# frozen_string_literal: true

require 'rails_helper'

describe 'Create a Book', :feature, js: true do
  let(:submitter) { FactoryBot.build(:submitter) }
  let(:book) { FactoryBot.build(:book) }

  it 'from publications index page' do
    create_submitter(submitter)
    visit publications_path
    find(:xpath, "//a[@href='#{Rails.application.routes.url_helpers.new_book_path}']").click

    # New Book Page
    expect(page).to have_current_path(Rails.application.routes.url_helpers.new_book_path)
    (0..book.author_first_name.count - 1).each do |i|
      click_on('Add Author') if i != 0
      all(:xpath, "//input[@name='book[author_first_name][]']").last.set(book.author_first_name[i])
      all(:xpath, "//input[@name='book[author_last_name][]']").last.set(book.author_last_name[i])
    end
    (0..book.college_ids.count - 1).each do |i|
      check "book_college_ids_#{book.college_ids[i]}"
    end
    fill_in('book[uc_department]', with: book.uc_department)
    fill_in('book[work_title]', with: book.work_title)
    fill_in('book[other_title]', with: book.other_title)
    fill_in('book[publisher]', with: book.publisher)
    fill_in('book[city]', with: book.city)
    fill_in('book[publication_date]', with: book.publication_date)
    fill_in('book[url]', with: book.url)
    fill_in('book[doi]', with: book.doi)
    click_on('Submit')

    expect(page).to have_current_path(Rails.application.routes.url_helpers.publications_path)

    # Check values
    expect(page).to have_text 'First Last, Second None'
    expect(page).to have_text 'Arts and Sciences'
    expect(page).to have_text 'Department'
    expect(page).to have_text 'Title'
    expect(page).to have_text 'Subtitle'
    expect(page).to have_text 'Publisher'
    expect(page).to have_text 'City'
    expect(page).to have_text 'Publication Date'
    expect(page).to have_text 'URL'
    expect(page).to have_text 'DOI'
  end
end
