# frozen_string_literal: true

require 'rails_helper'

# When adding an author or artist for a publication, the page should
# correctly display the title of the author or artist as "Author" or "Artist".
# This is a feature test that checks the behavior of the page when adding
# and deleting authors and artists.
describe 'Author and Artist labels', :feature, js: true do
  let(:submitter) { FactoryBot.create(:submitter) }
  let(:book) { FactoryBot.create(:book, author_first_name: ['First0'], author_last_name: ['Last0']) }
  let(:book_id) { book.id }
  let(:artwork) { FactoryBot.create(:artwork, author_first_name: ['First0'], author_last_name: ['Last0']) }
  let(:artwork_id) { artwork.id }

  before do
    create_submitter(submitter)
  end

  it 'uses the title of Author for new books' do
    visit new_book_path
    expect(page).to have_selector("input[name='book[author_first_name][]']", visible: true)

    expect(page).to have_content('Add Author')
    expect(page).not_to have_content('Add Artist')

    add_author_or_artist_and_verify_field
    add_author_or_artist_and_verify_field

    expect(page).to have_selector('button', text: 'Remove Author', count: 2)
    expect(page).not_to have_selector('button', text: 'Remove Artist')

    first('button', text: 'Remove Author').click
    expect(page).to have_selector('button', text: 'Remove Author', count: 1)
    expect(page).not_to have_content('Artist')
  end

  it 'has the title of Artist for new artworks' do
    visit new_artwork_path
    expect(page).to have_selector("input[name='artwork[author_first_name][]']", visible: true)

    expect(page).to have_content('Add Artist')
    expect(page).not_to have_content('Add Author')

    add_author_or_artist_and_verify_field
    add_author_or_artist_and_verify_field

    expect(page).to have_selector('button', text: 'Remove Artist', count: 2)
    expect(page).not_to have_selector('button', text: 'Remove Author')

    first('button', text: 'Remove Artist').click
    expect(page).to have_selector('button', text: 'Remove Artist', count: 1)
    expect(page).not_to have_content('Author')
  end

  it 'uses the title of Author for existing books' do
    login_as_admin

    visit edit_book_path(book)
    expect(page).to have_selector("input[name='book[author_first_name][]']", visible: true)

    expect(page).to have_content('Add Author')
    expect(page).not_to have_content('Add Artist')

    add_author_or_artist_and_verify_field
    add_author_or_artist_and_verify_field

    expect(page).to have_selector('button', text: 'Remove Author', count: 2)
    expect(page).not_to have_selector('button', text: 'Remove Artist')

    first('button', text: 'Remove Author').click
    expect(page).to have_selector('button', text: 'Remove Author', count: 1)
    expect(page).not_to have_content('Artist')
  end

  it 'has the title of Artist for existing artworks' do
    login_as_admin

    visit edit_artwork_path(artwork)
    expect(page).to have_selector("input[name='artwork[author_first_name][]']", visible: true)

    expect(page).to have_content('Add Artist')
    expect(page).not_to have_content('Add Author')

    add_author_or_artist_and_verify_field
    add_author_or_artist_and_verify_field

    expect(page).to have_selector('button', text: 'Remove Artist', count: 2)
    expect(page).not_to have_selector('button', text: 'Remove Author')

    first('button', text: 'Remove Artist').click
    expect(page).to have_selector('button', text: 'Remove Artist', count: 1)
    expect(page).not_to have_content('Author')
  end
end
