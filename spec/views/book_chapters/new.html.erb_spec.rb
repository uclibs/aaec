# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'book_chapters/new', type: :view do
  before(:each) do
    @book_chapter = FactoryBot.build(:book_chapter)
  end

  it 'renders new book_chapter form' do
    render

    assert_select 'form[action=?][method=?]', book_chapters_path, 'post' do
      assert_select 'input[name=?]', 'book_chapter[author_first_name][]'

      assert_select 'input[name=?]', 'book_chapter[author_last_name][]'

      assert_select 'input[name=?]', 'book_chapter[college_ids][]'

      assert_select 'input[name=?]', 'book_chapter[uc_department]'

      assert_select 'input[name=?]', 'book_chapter[work_title]'

      assert_select 'input[name=?]', 'book_chapter[other_title]'

      assert_select 'input[name=?]', 'book_chapter[publisher]'

      assert_select 'input[name=?]', 'book_chapter[city]'

      assert_select 'input[name=?]', 'book_chapter[page_numbers]'

      assert_select 'input[name=?]', 'book_chapter[publication_date]'

      assert_select 'input[name=?]', 'book_chapter[url]'

      assert_select 'input[name=?]', 'book_chapter[doi]'

      assert_select 'input[name=?]', 'book_chapter[submitter_id]'
    end
  end
end
