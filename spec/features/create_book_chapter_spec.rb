# frozen_string_literal: true

require 'rails_helper'

describe 'Create a book_chapter', :feature, js: true do
  let(:submitter) { FactoryBot.build(:submitter) }
  let(:book_chapter) { FactoryBot.build(:book_chapter) }

  it 'from publications index page' do
    create_submitter(submitter)
    visit publications_path
    find(:xpath, "//a[@href='#{Rails.application.routes.url_helpers.new_book_chapter_path}']").click

    # New book_chapter Page
    expect(page).to have_current_path(Rails.application.routes.url_helpers.new_book_chapter_path)
    (0..book_chapter.author_first_name.count - 1).each do |i|
      click_on('Add Author') if i != 0
      all(:xpath, "//input[@name='book_chapter[author_first_name][]']").last.set(book_chapter.author_first_name[i])
      all(:xpath, "//input[@name='book_chapter[author_last_name][]']").last.set(book_chapter.author_last_name[i])
    end
    (0..book_chapter.college_ids.count - 1).each do |i|
      check "book_chapter_college_ids_#{book_chapter.college_ids[i]}"
    end
    fill_in('book_chapter[uc_department]', with: book_chapter.uc_department)
    fill_in('book_chapter[work_title]', with: book_chapter.work_title)
    fill_in('book_chapter[other_title]', with: book_chapter.other_title)
    fill_in('book_chapter[publisher]', with: book_chapter.publisher)
    fill_in('book_chapter[city]', with: book_chapter.city)
    fill_in('book_chapter[publication_date]', with: book_chapter.publication_date)
    fill_in('book_chapter[url]', with: book_chapter.url)
    fill_in('book_chapter[doi]', with: book_chapter.doi)
    click_on('Submit')

    expect(page).to have_current_path(Rails.application.routes.url_helpers.publications_path)

    # Check values
    expect(page).to have_text 'First Last'
    expect(page).to have_text 'Second None'
    expect(page).to have_text 'Arts and Sciences'
    expect(page).to have_text 'Department'
    expect(page).to have_text 'Title'
    expect(page).not_to have_text 'Subtitle'
    expect(page).not_to have_text 'Publisher'
    expect(page).not_to have_text 'City'
    expect(page).not_to have_text 'Publication Date'
    expect(page).not_to have_text 'URL'
    expect(page).not_to have_text 'DOI'
  end
end
