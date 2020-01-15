# frozen_string_literal: true

json.extract! other_publication, :id, :author_first_name, :author_last_name, :college_ids, :uc_department, :work_title, :other_title, :volume, :issue, :page_numbers, :publisher, :city, :publication_date, :url, :doi, :submitter_id, :created_at, :updated_at
json.url other_publication_url(other_publication, format: :json)
