# frozen_string_literal: true

FactoryBot.define do
  factory :artwork do
    author_first_name { %w[First Second] }
    author_last_name  { %w[Last None] }
    college_ids { [2] }
    uc_department { 'Department' }
    work_title { 'Title' }
    other_title { 'Subtitle' }
    location { 'Location' }
    date { 'Date' }
    submitter_id { '1' }
  end
end
