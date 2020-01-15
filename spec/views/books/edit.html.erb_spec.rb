# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'books/edit', type: :view do
  before(:each) do
    @book = assign(:book, Book.create!(
                            author_first_name: 'MyString',
                            author_last_name: 'MyString',
                            college_ids: [1],
                            uc_department: 'MyString',
                            work_title: 'MyString',
                            other_title: 'MyString',
                            publisher: 'MyString',
                            city: 'MyString',
                            publication_date: 'MyString',
                            url: 'MyString',
                            doi: 'MyString',
                            submitter_id: 'MyString'
                          ))
  end

  it 'renders the edit book form' do
    render

    assert_select 'form[action=?][method=?]', book_path(@book), 'post' do
      assert_select 'input[name=?]', 'book[author_first_name]'

      assert_select 'input[name=?]', 'book[author_last_name]'

      assert_select 'input[name=?]', 'book[college_ids][]'

      assert_select 'input[name=?]', 'book[uc_department]'

      assert_select 'input[name=?]', 'book[work_title]'

      assert_select 'input[name=?]', 'book[other_title]'

      assert_select 'input[name=?]', 'book[publisher]'

      assert_select 'input[name=?]', 'book[city]'

      assert_select 'input[name=?]', 'book[publication_date]'

      assert_select 'input[name=?]', 'book[url]'

      assert_select 'input[name=?]', 'book[doi]'

      assert_select 'input[name=?]', 'book[submitter_id]'
    end
  end
end
