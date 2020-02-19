# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'books/show', type: :view do
  before(:each) do
    @book = FactoryBot.create(:book)
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/First Last, Second None/)
    expect(rendered).to match(/Arts and Sciences, Other: Test/)
    expect(rendered).to match(/Department/)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Subtitle/)
    expect(rendered).to match(/Publisher/)
    expect(rendered).to match(/City/)
    expect(rendered).to match(/Publication Date/)
    expect(rendered).to match(/URL/)
    expect(rendered).to match(/DOI/)
  end
end
