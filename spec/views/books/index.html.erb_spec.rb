# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'books/index', type: :view do
  before(:each) do
    assign(:books, [FactoryBot.create(:book), FactoryBot.create(:book)])
  end

  it 'renders a list of books' do
    render
    assert_select 'tr>td', text: 'First Last'.to_s, count: 2
    assert_select 'tr>td', text: 'Arts and Sciences'.to_s, count: 2
    assert_select 'tr>td', text: 'Department'.to_s, count: 2
    assert_select 'tr>td', text: 'Title'.to_s, count: 2
    assert_select 'tr>td', text: 'Subtitle'.to_s, count: 2
    assert_select 'tr>td', text: 'Publisher'.to_s, count: 2
    assert_select 'tr>td', text: 'City'.to_s, count: 2
    assert_select 'tr>td', text: 'Publication Date'.to_s, count: 2
    assert_select 'tr>td', text: 'URL'.to_s, count: 2
    assert_select 'tr>td', text: 'DOI'.to_s, count: 2
    assert_select 'tr>td', text: 'Submitter ID'.to_s, count: 2
  end
end
