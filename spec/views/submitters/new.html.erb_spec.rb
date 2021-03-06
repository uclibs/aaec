# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'submitters/new', type: :view do
  before(:each) do
    assign(:submitter, FactoryBot.build(:submitter))
  end

  it 'renders new submitter form' do
    render

    assert_select 'form[action=?][method=?]', submitters_path, 'post' do
      assert_select 'input[name=?]', 'submitter[first_name]'

      assert_select 'input[name=?]', 'submitter[last_name]'

      assert_select 'select[name=?]', 'submitter[college]'

      assert_select 'input[name=?]', 'submitter[department]'

      assert_select 'input[name=?]', 'submitter[mailing_address]'

      assert_select 'input[name=?]', 'submitter[phone_number]'

      assert_select 'input[name=?]', 'submitter[email_address]'
    end
  end

  it 'shows instructions' do
    render

    expect(rendered).to include('Instructions')
    expect(rendered).to include('melissa.norris@uc.edu')
  end
end
