# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'other_publications/edit', type: :view do
  before(:each) do
    @other_publication = FactoryBot.create(:other_publication)
  end

  it 'renders the edit other_publication form' do
    render

    assert_select 'form[action=?][method=?]', other_publication_path(@other_publication), 'post' do
      assert_select 'input[name=?]', 'other_publication[author_first_name][]'

      assert_select 'input[name=?]', 'other_publication[author_last_name][]'

      assert_select 'input[name=?]', 'other_publication[college_ids][]'

      assert_select 'input[name=?]', 'other_publication[other_college]'

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
