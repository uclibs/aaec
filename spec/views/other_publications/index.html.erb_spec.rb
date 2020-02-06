# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'other_publications/index', type: :view do
  before(:each) do
    @other_publications = [FactoryBot.create(:other_publication), FactoryBot.create(:other_publication)]
  end

  it 'renders a list of other_publications' do
    render
    assert_select 'tr>td', text: 'First Last, Second None'.to_s, count: 2
    assert_select 'tr>td', text: 'Arts and Sciences'.to_s, count: 2
    assert_select 'tr>td', text: 'Department'.to_s, count: 2
    assert_select 'tr>td', text: 'Title'.to_s, count: 2
    assert_select 'tr>td', text: 'Subtitle'.to_s, count: 2
    assert_select 'tr>td', text: 'Volume'.to_s, count: 2
    assert_select 'tr>td', text: 'Issue'.to_s, count: 2
    assert_select 'tr>td', text: 'Page Numbers'.to_s, count: 2
    assert_select 'tr>td', text: 'Publisher'.to_s, count: 2
    assert_select 'tr>td', text: 'City'.to_s, count: 2
    assert_select 'tr>td', text: 'Publication Date'.to_s, count: 2
    assert_select 'tr>td', text: 'URL'.to_s, count: 2
    assert_select 'tr>td', text: 'DOI'.to_s, count: 2
  end
end
