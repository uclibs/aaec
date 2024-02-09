# frozen_string_literal: true

def login_as_admin
  visit manage_path
  fill_in('username', with: ENV.fetch('ADMIN_USERNAME', nil))
  fill_in('password', with: ENV.fetch('ADMIN_PASSWORD', nil))
  click_on('Submit')
end

def visit_publications_page_as_submitter(submitter)
  create_submitter(submitter)
end

def visit_publications_page_as_admin
  visit manage_path
  fill_in('username', with: ENV.fetch('ADMIN_USERNAME', nil))
  fill_in('password', with: ENV.fetch('ADMIN_PASSWORD', nil))
  click_on('Submit')
end

def make_authenticity_token_invalid
  expect(page).to have_selector('input[name=authenticity_token]', visible: false)
  page.execute_script("document.querySelector('input[name=authenticity_token]').value = 'invalid_token';")
end

def expect_to_be_on_root_page_with_expired_error
  expect(page).to have_current_path(root_path)
  expect(page).to have_content('Your session has expired. Please log in again.')
end

def expect_to_be_on_root_page_with_login_message
  expect(page).to have_current_path(root_path)
  expect(page).to have_content('You must submit your information first.')
end

def expect_to_be_on_manage_page_with_expired_error
  expect(page).to have_current_path(manage_path)
  expect(page).to have_content('Your session has expired. Please log in again.')
end
