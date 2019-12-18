# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'submitters/edit', type: :view do
  before(:each) do
    @submitter = assign(:submitter, Submitter.create!(
                                      first_name: 'MyString',
                                      last_name: 'MyString',
                                      college: 'UC Libraries',
                                      department: 'MyString',
                                      mailing_address: 'MyString',
                                      phone_number: '111-111-1111',
                                      email_address: 'test@mail.uc.edu'
                                    ))
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
