# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'JavascriptForm', type: :feature, js: true do
  scenario 'addAuthor function sets autocomplete to off' do
    visit new_other_publication_path

    # Use CSS selector to verify that the newly added fields have autocomplete='off'
    expect(page).to have_selector("input[autocomplete='off'][name*='[author_first_name]']")
    expect(page).to have_selector("input[autocomplete='off'][name*='[author_last_name]']")
  end
end
