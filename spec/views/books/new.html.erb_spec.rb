# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'books/new', type: :view do
  before(:each) do
    assign(:book, FactoryBot.build(:book))
  end

  it 'renders new book form' do
    render

    assert_select 'form[action=?][method=?]', books_path, 'post' do
      assert_select 'input[name=?]', 'book[author_first_name][]'

      assert_select 'input[name=?]', 'book[author_last_name][]'

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
