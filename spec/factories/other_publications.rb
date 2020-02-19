# frozen_string_literal: true

FactoryBot.define do
  factory :other_publication do
    author_first_name { %w[First Second] }
    author_last_name  { %w[Last None] }
    college_ids { [2, 16] }
    uc_department { 'Department' }
    work_title { 'Title' }
    other_title { 'Subtitle' }
    volume { 'Volume' }
    issue { 'Issue' }
    page_numbers { 'Page Numbers' }
    publisher { 'Publisher' }
    city { 'City' }
    publication_date { 'Publication Date' }
    url  { 'URL' }
    doi  { 'DOI' }
    submitter_id { '1' }
    other_college { 'Test' }
  end
end
