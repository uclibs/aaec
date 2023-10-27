# frozen_string_literal: true

FactoryBot.define do
  factory :musical_score do
    author_first_name { %w[First Second] }
    author_last_name  { %w[Last None] }
    college_ids { [2] }
    uc_department { 'Department' }
    work_title { 'Title' }
    other_title { 'Subtitle' }
    publisher { 'Publisher' }
    city { 'City' }
    publication_date { 'Publication Date' }
    url  { 'URL' }
    doi  { 'DOI' }
    submitter { association :submitter }
  end
end
