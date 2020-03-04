# frozen_string_literal: true

FactoryBot.define do
  factory :digital_project do
    author_first_name { %w[First Second] }
    author_last_name  { %w[Last None] }
    college_ids { [2] }
    uc_department { 'Department' }
    work_title { 'Title' }
    other_title { 'Subtitle' }
    name_of_site { 'Name of site' }
    name_of_affiliated_organization { 'Name of affiliated organization' }
    publication_date { 'Publication Date' }
    version { 'Version ' }
    url  { 'URL' }
    doi  { 'DOI' }
    submitter_id { '1' }
  end
end
