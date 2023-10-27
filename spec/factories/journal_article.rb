# frozen_string_literal: true

FactoryBot.define do
  factory :journal_article do
    author_first_name { %w[First Second] }
    author_last_name  { %w[Last None] }
    college_ids { [2] }
    uc_department { 'Department' }
    work_title { 'Title' }
    other_title { 'Subtitle' }
    volume { 'Volume' }
    issue { 'Issue' }
    page_numbers { 'Page Numbers' }
    publication_date { 'Publication Date' }
    url  { 'URL' }
    doi  { 'DOI' }
    submitter { association :submitter }
  end
end
