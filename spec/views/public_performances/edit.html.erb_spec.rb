# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'public_performances/edit', type: :view do
  before(:each) do
    @public_performance = FactoryBot.create(:public_performance)
  end

  it 'renders the edit public_performance form' do
    render

    assert_select 'form[action=?][method=?]', public_performance_path(@public_performance), 'post' do
      assert_select 'input[name=?]', 'public_performance[author_first_name][]'

      assert_select 'input[name=?]', 'public_performance[author_last_name][]'

      assert_select 'input[name=?]', 'public_performance[college_ids][]'

      assert_select 'input[name=?]', 'public_performance[uc_department]'

      assert_select 'input[name=?]', 'public_performance[work_title]'

      assert_select 'input[name=?]', 'public_performance[other_title]'

      assert_select 'input[name=?]', 'public_performance[location]'

      assert_select 'input[name=?]', 'public_performance[time]'

      assert_select 'input[name=?]', 'public_performance[date]'

      assert_select 'input[name=?]', 'public_performance[submitter_id]'
    end
  end
end
