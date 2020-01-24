# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'other_publications/new', type: :view do
  before(:each) do
    assign(:other_publication, OtherPublication.new(
                                 author_first_name: ['MyString'],
                                 author_last_name: ['MyString'],
                                 college_ids: [1],
                                 uc_department: 'MyString',
                                 work_title: 'MyString',
                                 other_title: 'MyString',
                                 volume: 'MyString',
                                 issue: 'MyString',
                                 page_numbers: 'MyString',
                                 publisher: 'MyString',
                                 city: 'MyString',
                                 publication_date: 'MyString',
                                 url: 'MyString',
                                 doi: 'MyString',
                                 submitter_id: 'MyString'
                               ))
  end

  it 'renders new other_publication form' do
    render

    assert_select 'form[action=?][method=?]', other_publications_path, 'post' do
      assert_select 'input[name=?]', 'other_publication[college_ids][]'

      assert_select 'input[name=?]', 'other_publication[uc_department]'

      assert_select 'input[name=?]', 'other_publication[work_title]'

      assert_select 'input[name=?]', 'other_publication[other_title]'

      assert_select 'input[name=?]', 'other_publication[volume]'

      assert_select 'input[name=?]', 'other_publication[issue]'

      assert_select 'input[name=?]', 'other_publication[page_numbers]'

      assert_select 'input[name=?]', 'other_publication[publisher]'

      assert_select 'input[name=?]', 'other_publication[city]'

      assert_select 'input[name=?]', 'other_publication[publication_date]'

      assert_select 'input[name=?]', 'other_publication[url]'

      assert_select 'input[name=?]', 'other_publication[doi]'

      assert_select 'input[name=?]', 'other_publication[submitter_id]'
    end
  end
end
