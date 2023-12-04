# frozen_string_literal: true

def visit_publications_page_as_submitter(submitter)
  create_submitter(submitter)
  visit publications_path
end

def visit_publications_page_as_admin
  visit manage_path
  fill_in('username', with: ENV['ADMIN_USERNAME'])
  fill_in('password', with: ENV['ADMIN_PASSWORD'])
  click_on('Submit')
  visit publications_path
end