# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'artworks/edit', type: :view do
  before(:each) do
    @artwork = FactoryBot.create(:artwork)
  end

  it 'renders the edit artwork form' do
    render

    assert_select 'form[action=?][method=?]', artwork_path(@artwork), 'post' do
      assert_select 'input[name=?]', 'artwork[author_first_name][]'

      assert_select 'input[name=?]', 'artwork[author_last_name][]'

      assert_select 'input[name=?]', 'artwork[college_ids][]'

      assert_select 'input[name=?]', 'artwork[uc_department]'

      assert_select 'input[name=?]', 'artwork[work_title]'

      assert_select 'input[name=?]', 'artwork[other_title]'

      assert_select 'input[name=?]', 'artwork[location]'

      assert_select 'input[name=?]', 'artwork[date]'

      assert_select 'input[name=?]', 'artwork[submitter_id]'
    end
  end
end
