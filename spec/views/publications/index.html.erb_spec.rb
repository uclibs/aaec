# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'publications/index', type: :view do
  before(:each) do
    assign(:submitters, [
             Submitter.create!(
               first_name: 'First Name',
               last_name: 'Last Name',
               college: 2,
               department: 'Department',
               mailing_address: 'Mailing Address',
               phone_number: '111-111-1111',
               email_address: 'test@mail.uc.edu'
             )
           ])
  end

  before do
    controller.params[:submitter_id] = 1
    @books = []
    @other_publications = []
  end

  it 'renders a list of submitters' do
    render
    expect(rendered).to have_content('First Name', count: 1)
    expect(rendered).to have_content('Last Name', count: 1)
    expect(rendered).to have_content('2', count: 1)
    expect(rendered).to have_content('Department', count: 1)
    expect(rendered).to have_content('Mailing Address', count: 1)
    expect(rendered).to have_content('111-111-1111', count: 1)
    expect(rendered).to have_content('test@mail.uc.edu', count: 1)
    expect(rendered).to have_content('Books', count: 1)
    expect(rendered).to have_content('Other Publications', count: 1)
  end
end
