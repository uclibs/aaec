# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'journal_articles/show', type: :view do
  before(:each) do
    @journal_article = FactoryBot.create(:journal_article)
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/First Last/)
    expect(rendered).to match(/Arts and Sciences/)
    expect(rendered).to match(/Department/)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Subtitle/)
    expect(rendered).to match(/Volume/)
    expect(rendered).to match(/Issue/)
    expect(rendered).to match(/Page Numbers/)
    expect(rendered).to match(/Publication Date/)
    expect(rendered).to match(/URL/)
    expect(rendered).to match(/DOI/)
  end
end
