# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'physical_media/edit', type: :view do
  before(:each) do
    @physical_medium = FactoryBot.create(:physical_medium)
  end

  it 'renders the edit physical_medium form' do
    render

    assert_select 'form[action=?][method=?]', physical_medium_path(@physical_medium), 'post' do
      assert_select 'input[name=?]', 'physical_medium[author_first_name][]'

      assert_select 'input[name=?]', 'physical_medium[author_last_name][]'

      assert_select 'input[name=?]', 'physical_medium[college_ids][]'

      assert_select 'input[name=?]', 'physical_medium[uc_department]'

      assert_select 'input[name=?]', 'physical_medium[work_title]'

      assert_select 'input[name=?]', 'physical_medium[other_title]'

      assert_select 'input[name=?]', 'physical_medium[publisher]'

      assert_select 'input[name=?]', 'physical_medium[city]'

      assert_select 'input[name=?]', 'physical_medium[publication_date]'

      assert_select 'input[name=?]', 'physical_medium[url]'

      assert_select 'input[name=?]', 'physical_medium[doi]'

      assert_select 'input[name=?]', 'physical_medium[submitter_id]'
    end
  end
end
