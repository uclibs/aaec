# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'photographies/new', type: :view do
  before(:each) do
    @photography = FactoryBot.build(:photography)
  end

  it 'renders new photography form' do
    render

    assert_select 'form[action=?][method=?]', photographies_path, 'post' do
      assert_select 'input[name=?]', 'photography[author_first_name][]'

      assert_select 'input[name=?]', 'photography[author_last_name][]'

      assert_select 'input[name=?]', 'photography[college_ids][]'

      assert_select 'input[name=?]', 'photography[uc_department]'

      assert_select 'input[name=?]', 'photography[work_title]'

      assert_select 'input[name=?]', 'photography[other_title]'

      assert_select 'input[name=?]', 'photography[publisher]'

      assert_select 'input[name=?]', 'photography[city]'

      assert_select 'input[name=?]', 'photography[publication_date]'

      assert_select 'input[name=?]', 'photography[url]'

      assert_select 'input[name=?]', 'photography[doi]'

      assert_select 'input[name=?]', 'photography[submitter_id]'
    end
  end
end
