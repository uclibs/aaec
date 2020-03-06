# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'editings/edit', type: :view do
  before(:each) do
    @editing = FactoryBot.create(:editing)
  end

  it 'renders the edit editing form' do
    render

    assert_select 'form[action=?][method=?]', editing_path(@editing), 'post' do
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
