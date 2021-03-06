# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'musical_scores/edit', type: :view do
  before(:each) do
    @musical_score = FactoryBot.create(:musical_score)
  end

  it 'renders the edit musical_score form' do
    render

    assert_select 'form[action=?][method=?]', musical_score_path(@musical_score), 'post' do
      assert_select 'input[name=?]', 'musical_score[author_first_name][]'

      assert_select 'input[name=?]', 'musical_score[author_last_name][]'

      assert_select 'input[name=?]', 'musical_score[college_ids][]'

      assert_select 'input[name=?]', 'musical_score[uc_department]'

      assert_select 'input[name=?]', 'musical_score[work_title]'

      assert_select 'input[name=?]', 'musical_score[other_title]'

      assert_select 'input[name=?]', 'musical_score[publisher]'

      assert_select 'input[name=?]', 'musical_score[city]'

      assert_select 'input[name=?]', 'musical_score[publication_date]'

      assert_select 'input[name=?]', 'musical_score[url]'

      assert_select 'input[name=?]', 'musical_score[doi]'

      assert_select 'input[name=?]', 'musical_score[submitter_id]'
    end
  end
end
