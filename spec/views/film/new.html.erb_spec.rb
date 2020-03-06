# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'films/new', type: :view do
  before(:each) do
    @film = FactoryBot.build(:film)
  end

  it 'renders new film form' do
    render

    assert_select 'form[action=?][method=?]', films_path, 'post' do
      assert_select 'input[name=?]', 'film[author_first_name][]'

      assert_select 'input[name=?]', 'film[author_last_name][]'

      assert_select 'input[name=?]', 'film[college_ids][]'

      assert_select 'input[name=?]', 'film[uc_department]'

      assert_select 'input[name=?]', 'film[work_title]'

      assert_select 'input[name=?]', 'film[other_title]'

      assert_select 'input[name=?]', 'film[director]'

      assert_select 'input[name=?]', 'film[producer]'

      assert_select 'input[name=?]', 'film[release_year]'

      assert_select 'input[name=?]', 'film[submitter_id]'
    end
  end
end
