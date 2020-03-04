# frozen_string_literal: true

require 'rails_helper'

describe 'Create a Journal Article', :feature, js: true do
  let(:submitter) { FactoryBot.build(:submitter) }
  let(:journal_article) { FactoryBot.build(:journal_article) }

  it 'from publications index page' do
    create_submitter(submitter)
    visit publications_path
    find(:xpath, "//a[@href='#{Rails.application.routes.url_helpers.new_journal_article_path}']").click

    # New Journal Article Page
    expect(page).to have_current_path(Rails.application.routes.url_helpers.new_journal_article_path)
    (0..journal_article.author_first_name.count - 1).each do |i|
      click_on('Add Author') if i != 0
      all(:xpath, "//input[@name='journal_article[author_first_name][]']").last.set(journal_article.author_first_name[i])
      all(:xpath, "//input[@name='journal_article[author_last_name][]']").last.set(journal_article.author_last_name[i])
    end
    (0..journal_article.college_ids.count - 1).each do |i|
      check "journal_article_college_ids_#{journal_article.college_ids[i]}"
    end
    fill_in('journal_article[uc_department]', with: journal_article.uc_department)
    fill_in('journal_article[work_title]', with: journal_article.work_title)
    fill_in('journal_article[other_title]', with: journal_article.other_title)
    fill_in('journal_article[volume]', with: journal_article.volume)
    fill_in('journal_article[issue]', with: journal_article.issue)
    fill_in('journal_article[page_numbers]', with: journal_article.page_numbers)
    fill_in('journal_article[publisher]', with: journal_article.publisher)
    fill_in('journal_article[city]', with: journal_article.city)
    fill_in('journal_article[publication_date]', with: journal_article.publication_date)
    fill_in('journal_article[url]', with: journal_article.url)
    fill_in('journal_article[doi]', with: journal_article.doi)
    click_on('Submit')

    expect(page).to have_current_path(Rails.application.routes.url_helpers.publications_path)

    # Check values
    expect(page).to have_text 'First Last'
    expect(page).to have_text 'Second None'
    expect(page).to have_text 'Arts and Sciences'
    expect(page).to have_text 'Department'
    expect(page).to have_text 'Title'
    expect(page).not_to have_text 'Subtitle'
    expect(page).not_to have_text 'Volume'
    expect(page).not_to have_text 'Issue'
    expect(page).not_to have_text 'Page Numbers'
    expect(page).not_to have_text 'Publisher'
    expect(page).not_to have_text 'City'
    expect(page).not_to have_text 'Publication Date'
    expect(page).not_to have_text 'URL'
    expect(page).not_to have_text 'DOI'
  end
end
