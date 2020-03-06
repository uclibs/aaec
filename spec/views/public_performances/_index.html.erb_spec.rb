# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'public_performances/_index', type: :view do
  before(:each) do
    @public_performances = [FactoryBot.create(:public_performance), FactoryBot.create(:public_performance)]
  end

  it 'renders a list of public_performances' do
    render
    assert_select 'tr>td', text: 'Title'.to_s, count: 2
    assert_select 'tr>td>div', text: 'First Last'.to_s, count: 2
    assert_select 'tr>td>div', text: 'Second None'.to_s, count: 2
    assert_select 'tr>td', text: 'Arts and Sciences'.to_s, count: 2
    assert_select 'tr>td', text: 'Department'.to_s, count: 2
  end
end
