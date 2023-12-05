# frozen_string_literal: true


def visit_publications_page_as_submitter(submitter)
  create_submitter(submitter)
  visit publications_path
end

def visit_publications_page_as_admin
  visit manage_path
  fill_in('username', with: ENV.fetch('ADMIN_USERNAME', nil))
  fill_in('password', with: ENV.fetch('ADMIN_PASSWORD', nil))
  click_on('Submit')
  visit publications_path
end
