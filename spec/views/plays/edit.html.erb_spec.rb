# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'plays/edit', type: :view do
  before(:each) do
    @play = FactoryBot.create(:play)
  end

  it 'renders the edit play form' do
    render

    assert_select 'form[action=?][method=?]', play_path(@play), 'post' do
      assert_select 'input[name=?]', 'play[author_first_name][]'

      assert_select 'input[name=?]', 'play[author_last_name][]'

      assert_select 'input[name=?]', 'play[college_ids][]'

      assert_select 'input[name=?]', 'play[uc_department]'

      assert_select 'input[name=?]', 'play[work_title]'

      assert_select 'input[name=?]', 'play[other_title]'

      assert_select 'input[name=?]', 'play[publisher]'

      assert_select 'input[name=?]', 'play[city]'

      assert_select 'input[name=?]', 'play[publication_date]'

      assert_select 'input[name=?]', 'play[url]'

      assert_select 'input[name=?]', 'play[doi]'

      assert_select 'input[name=?]', 'play[submitter_id]'
    end
  end
end
