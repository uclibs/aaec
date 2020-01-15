# frozen_string_literal: true

json.extract! college, :id, :name, :created_at, :updated_at
json.url college_url(college, format: :json)
