# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'AutocompleteOffFormBuilder', type: :feature do
  scenario 'renders text field with autocomplete off' do
    visit root_path
    expect(page).to have_selector("input[autocomplete='off']")
    expect(page).to have_selector("select[autocomplete='off']")

    visit manage_path
    expect(page).to have_selector("input[autocomplete='off']")
  end
end
