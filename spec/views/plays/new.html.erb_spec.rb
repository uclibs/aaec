# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'plays/new', type: :view do
  before(:each) do
    @play = FactoryBot.build(:play)
  end

  it 'renders new play form' do
    render

    assert_select 'form[action=?][method=?]', plays_path, 'post' do
      assert_select 'input[name=?]', 'play[author_first_name][]'

      assert_select 'input[name=?]', 'play[author_last_name][]'

      assert_select 'input[name=?]', 'play[college_ids][]'

      assert_select 'input[name=?]', 'play[uc_department]'

      assert_select 'input[name=?]', 'play[work_title]'

      assert_select 'input[name=?]', 'play[other_title]'

      assert_select 'input[name=?]', 'play[publisher]'

      assert_select 'input[name=?]', 'play[city]'

      assert_select 'input[name=?]', 'play[publication_date]'

      assert_select 'input[name=?]', 'play[url]'

      assert_select 'input[name=?]', 'play[doi]'

      assert_select 'input[name=?]', 'play[submitter_id]'
    end
  end
end
