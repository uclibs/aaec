# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'other_publications/show', type: :view do
  before(:each) do
    @other_publication = FactoryBot.create(:other_publication)
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/First Last, Second None/)
    expect(rendered).to match(/Arts and Sciences, Other: Test/)
    expect(rendered).to match(/Department/)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Subtitle/)
    expect(rendered).to match(/Volume/)
    expect(rendered).to match(/Issue/)
    expect(rendered).to match(/Page Numbers/)
    expect(rendered).to match(/Publisher/)
    expect(rendered).to match(/City/)
    expect(rendered).to match(/Publication Date/)
    expect(rendered).to match(/URL/)
    expect(rendered).to match(/DOI/)
  end
end
