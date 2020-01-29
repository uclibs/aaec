# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'submitters/edit', type: :view do
  before(:each) do
    @submitter = FactoryBot.create(:submitter)
  end

  it 'renders the edit submitter form' do
    render

    assert_select 'form[action=?][method=?]', submitter_path(@submitter), 'post' do
      assert_select 'input[name=?]', 'submitter[first_name]'

      assert_select 'input[name=?]', 'submitter[last_name]'

      assert_select 'select[name=?]', 'submitter[college]'

      assert_select 'input[name=?]', 'submitter[department]'

      assert_select 'input[name=?]', 'submitter[mailing_address]'

      assert_select 'input[name=?]', 'submitter[phone_number]'

      assert_select 'input[name=?]', 'submitter[email_address]'
    end
  end
end
