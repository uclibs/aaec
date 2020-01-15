# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'colleges/new', type: :view do
  before(:each) do
    assign(:college, College.new(
                       name: 'MyString'
                     ))
  end

  it 'renders new college form' do
    render

    assert_select 'form[action=?][method=?]', colleges_path, 'post' do
      assert_select 'input[name=?]', 'college[name]'
    end
  end
end
