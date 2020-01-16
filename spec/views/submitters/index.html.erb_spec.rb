# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'submitters/index', type: :view do
  before(:each) do
    assign(:submitters, [
             Submitter.create!(
               first_name: 'First Name',
               last_name: 'Last Name',
               college: 1,
               department: 'Department',
               mailing_address: 'Mailing Address',
               phone_number: '111-111-1111',
               email_address: 'test@mail.uc.edu'
             ),
             Submitter.create!(
               first_name: 'First Name',
               last_name: 'Last Name',
               college: 1,
               department: 'Department',
               mailing_address: 'Mailing Address',
               phone_number: '111-111-1111',
               email_address: 'test@mail.uc.edu'
             )
           ])
  end

  it 'renders a list of submitters' do
    render
    assert_select 'tr>td', text: 'First Name'.to_s, count: 2
    assert_select 'tr>td', text: 'Last Name'.to_s, count: 2
    assert_select 'tr>td', text: '1'.to_s, count: 2
    assert_select 'tr>td', text: 'Department'.to_s, count: 2
    assert_select 'tr>td', text: 'Mailing Address'.to_s, count: 2
    assert_select 'tr>td', text: '111-111-1111'.to_s, count: 2
    assert_select 'tr>td', text: 'test@mail.uc.edu'.to_s, count: 2
  end
end
