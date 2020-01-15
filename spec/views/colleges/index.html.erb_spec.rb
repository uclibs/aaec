# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'colleges/index', type: :view do
  before(:each) do
    assign(:colleges, [
             College.create!(
               name: 'Name'
             ),
             College.create!(
               name: 'Name'
             )
           ])
  end

  it 'renders a list of colleges' do
    render
    assert_select 'tr>td', text: 'Name'.to_s, count: 2
  end
end
