# frozen_string_literal: true

require 'rails_helper'

# When adding an author or artist for a publication, the page should
# correctly display the title of the author or artist as "Author" or "Artist".
# This is a feature test that checks the behavior of the page when adding
# and deleting authors and artists.
describe 'Author and Artist labels', :feature, js: true do
  let(:submitter) { FactoryBot.create(:submitter) }

  before do
    create_submitter(submitter)
  end

  it 'uses the title of Author for new books' do
    visit new_book_path
    expect(page).to have_content('Add Author')
    expect(page).not_to have_content('Add Artist')
    first_name_fields.last.set('First0')
    last_name_fields.last.set('Last0')
    click_on 'Add Author'
    first_name_fields.last.set('First1')
    last_name_fields.last.set('Last1')
    click_on 'Add Author'
    expect(page).to have_selector('button', text: 'Remove Author', count: 2)
    expect(page).not_to have_selector('button', text: 'Remove Artist')
    first('button', text: 'Remove Author').click
    expect(page).to have_selector('button', text: 'Remove Author', count: 1)
    expect(page).not_to have_content('Artist')
  end

  it 'has the title of Artist for new artworks' do
    visit new_artwork_path
    expect(page).to have_content('Add Artist')
    expect(page).not_to have_content('Add Author')
    first_name_fields.last.set('First0')
    last_name_fields.last.set('Last0')
    click_on 'Add Artist'
    first_name_fields.last.set('First1')
    last_name_fields.last.set('Last1')
    click_on 'Add Artist'
    expect(page).to have_selector('button', text: 'Remove Artist', count: 2)
    expect(page).not_to have_selector('button', text: 'Remove Author')
    first('button', text: 'Remove Artist').click
    expect(page).to have_selector('button', text: 'Remove Artist', count: 1)
    expect(page).not_to have_content('Author')
  end
end
