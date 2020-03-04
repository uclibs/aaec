# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'physical_media/_index', type: :view do
  before(:each) do
    @physical_media = [FactoryBot.create(:physical_medium), FactoryBot.create(:physical_medium)]
  end

  it 'renders a list of physical_media' do
    render
    assert_select 'tr>td', text: 'Title'.to_s, count: 2
    assert_select 'tr>td>div', text: 'First Last'.to_s, count: 2
    assert_select 'tr>td>div', text: 'Second None'.to_s, count: 2
    assert_select 'tr>td', text: 'Arts and Sciences'.to_s, count: 2
    assert_select 'tr>td', text: 'Department'.to_s, count: 2
  end
end
