# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'editings/new', type: :view do
  before(:each) do
    @editing = FactoryBot.build(:editing)
  end

  it 'renders new editing form' do
    render

    assert_select 'form[action=?][method=?]', editings_path, 'post' do
      assert_select 'input[name=?]', 'editing[author_first_name][]'

      assert_select 'input[name=?]', 'editing[author_last_name][]'

      assert_select 'input[name=?]', 'editing[college_ids][]'

      assert_select 'input[name=?]', 'editing[uc_department]'

      assert_select 'input[name=?]', 'editing[work_title]'

      assert_select 'input[name=?]', 'editing[other_title]'

      assert_select 'input[name=?]', 'editing[publisher]'

      assert_select 'input[name=?]', 'editing[city]'

      assert_select 'input[name=?]', 'editing[publication_date]'

      assert_select 'input[name=?]', 'editing[url]'

      assert_select 'input[name=?]', 'editing[doi]'

      assert_select 'input[name=?]', 'editing[submitter_id]'
    end
  end
end
