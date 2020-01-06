# frozen_string_literal: true

json.extract! submitter, :id, :first_name, :last_name, :college, :department, :mailing_address, :phone_number, :email_address, :created_at, :updated_at
json.url submitter_url(submitter, format: :json)
