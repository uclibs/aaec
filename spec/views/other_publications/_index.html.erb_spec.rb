# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'other_publications/_index', type: :view do
  before(:each) do
    @other_publications = [FactoryBot.create(:other_publication), FactoryBot.create(:other_publication)]
  end

  it 'renders a list of other_publications' do
    render
    assert_select 'tr>td', text: 'Title'.to_s, count: 2
    assert_select 'tr>td>div', text: 'First Last'.to_s, count: 2
    assert_select 'tr>td>div', text: 'Second None'.to_s, count: 2
    assert_select 'tr>td>div', text: 'Arts and Sciences'.to_s, count: 2
    assert_select 'tr>td>div', text: 'Other: Test'.to_s, count: 2
    assert_select 'tr>td', text: 'Department'.to_s, count: 2
  end
end
