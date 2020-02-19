# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'books/_index', type: :view do
  before(:each) do
    @books = [FactoryBot.create(:book), FactoryBot.create(:book)]
  end

  it 'renders a list of books' do
    render
    assert_select 'tr>td', text: 'Title'.to_s, count: 2
    assert_select 'tr>td>div', text: 'First Last'.to_s, count: 2
    assert_select 'tr>td>div', text: 'Second None'.to_s, count: 2
    assert_select 'tr>td>div', text: 'Arts and Sciences'.to_s, count: 2
    assert_select 'tr>td>div', text: 'Other: Test'.to_s, count: 2
    assert_select 'tr>td', text: 'Department'.to_s, count: 2
  end
end
