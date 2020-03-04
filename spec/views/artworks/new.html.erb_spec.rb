# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'artworks/new', type: :view do
  before(:each) do
    @artwork = FactoryBot.build(:artwork)
  end

  it 'renders new artwork form' do
    render

    assert_select 'form[action=?][method=?]', artworks_path, 'post' do
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
