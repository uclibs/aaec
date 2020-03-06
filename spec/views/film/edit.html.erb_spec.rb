# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'films/edit', type: :view do
  before(:each) do
    @film = FactoryBot.create(:film)
  end

  it 'renders the edit film form' do
    render

    assert_select 'form[action=?][method=?]', film_path(@film), 'post' do
      assert_select 'input[name=?]', 'film[author_first_name][]'

      assert_select 'input[name=?]', 'film[author_last_name][]'

      assert_select 'input[name=?]', 'film[college_ids][]'

      assert_select 'input[name=?]', 'film[uc_department]'

      assert_select 'input[name=?]', 'film[work_title]'

      assert_select 'input[name=?]', 'film[other_title]'

      assert_select 'input[name=?]', 'film[director]'

      assert_select 'input[name=?]', 'film[release_year]'

      assert_select 'input[name=?]', 'film[submitter_id]'
    end
  end
end
