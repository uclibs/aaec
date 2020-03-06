# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'physical_media/new', type: :view do
  before(:each) do
    @physical_medium = FactoryBot.build(:physical_medium)
  end

  it 'renders new physical_medium form' do
    render

    assert_select 'form[action=?][method=?]', physical_media_path, 'post' do
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
