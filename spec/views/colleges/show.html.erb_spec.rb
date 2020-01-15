# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'colleges/show', type: :view do
  before(:each) do
    @college = assign(:college, College.create!(
                                  name: 'Name'
                                ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
  end
end
