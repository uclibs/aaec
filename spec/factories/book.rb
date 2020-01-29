# frozen_string_literal: true

FactoryBot.define do
    factory :book do
        author_first_name  {['First'] }
        author_last_name  {['Last'] }
        college_ids  {[2] }
        uc_department  {'Department' }
        work_title  {'Title' }
        other_title  {'Subtitle' }
        publisher  {'Publisher' }
        city  {'City' }
        publication_date  {'Publication Date' }
        url  {'URL' }
        doi  {'DOI' }
        submitter_id  {'Submitter ID' }
    end
end