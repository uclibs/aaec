# frozen_string_literal: true

json.extract! book, :id, :author_first_name, :author_last_name, :college_ids, :uc_department, :work_title, :other_title, :publisher, :city, :publication_date, :url, :doi, :submitter_id, :created_at, :updated_at
json.url book_url(book, format: :json)
