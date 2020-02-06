# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'admin/login', type: :view do
  it 'renders a list of books' do
    render
    assert_select 'input[name=?]', 'username'
    assert_select 'input[name=?]', 'password'
  end
end
