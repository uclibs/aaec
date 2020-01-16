# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'submitters/show', type: :view do
  before(:each) do
    @submitter = assign(:submitter, Submitter.create!(
                                      first_name: 'First Name',
                                      last_name: 'Last Name',
                                      college: 1,
                                      department: 'Department',
                                      mailing_address: 'Mailing Address',
                                      phone_number: '111-111-1111',
                                      email_address: 'test@mail.uc.edu'
                                    ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/First Name/)
    expect(rendered).to match(/Last Name/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Department/)
    expect(rendered).to match(/Mailing Address/)
    expect(rendered).to match(/111-111-1111/)
    expect(rendered).to match(/test@mail.uc.edu/)
  end
end
