# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'musical_scores/_index', type: :view do
  before(:each) do
    @musical_scores = [FactoryBot.create(:musical_score), FactoryBot.create(:musical_score)]
  end

  it 'renders a list of musical_scores' do
    render
    assert_select 'tr>td', text: 'Title'.to_s, count: 2
    assert_select 'tr>td>div', text: 'First Last'.to_s, count: 2
    assert_select 'tr>td>div', text: 'Second None'.to_s, count: 2
    assert_select 'tr>td', text: 'Arts and Sciences'.to_s, count: 2
    assert_select 'tr>td', text: 'Department'.to_s, count: 2
  end
end
