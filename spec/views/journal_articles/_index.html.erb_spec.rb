# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'journal_articles/_index', type: :view do
  before(:each) do
    @journal_articles = [FactoryBot.create(:journal_article), FactoryBot.create(:journal_article)]
  end

  it 'renders a list of journal_articles' do
    render
    assert_select 'tr>td', text: 'Title'.to_s, count: 2
    assert_select 'tr>td>div', text: 'First Last'.to_s, count: 2
    assert_select 'tr>td>div', text: 'Second None'.to_s, count: 2
    assert_select 'tr>td', text: 'Arts and Sciences'.to_s, count: 2
    assert_select 'tr>td', text: 'Department'.to_s, count: 2
  end
end
