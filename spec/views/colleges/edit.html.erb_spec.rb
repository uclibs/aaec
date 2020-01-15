# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'colleges/edit', type: :view do
  before(:each) do
    @college = assign(:college, College.create!(
                                  name: 'MyString'
                                ))
  end

  it 'renders the edit college form' do
    render

    assert_select 'form[action=?][method=?]', college_path(@college), 'post' do
      assert_select 'input[name=?]', 'college[name]'
    end
  end
end
