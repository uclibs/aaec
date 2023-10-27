# frozen_string_literal: true

FactoryBot.define do
  factory :public_performance do
    author_first_name { %w[First Second] }
    author_last_name  { %w[Last None] }
    college_ids { [2] }
    uc_department { 'Department' }
    work_title { 'Title' }
    other_title { 'Subtitle' }
    location { 'Location' }
    time { 'Time' }
    date { 'Date' }
    submitter { association :submitter }
  end
end
