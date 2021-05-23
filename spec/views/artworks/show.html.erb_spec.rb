# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'artworks/show', type: :view do
  before(:each) do
    @artwork = FactoryBot.create(:artwork)
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/First/)
    expect(rendered).to match(/Last/)
    expect(rendered).to match(/Arts and Sciences/)
    expect(rendered).to match(/Department/)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Subtitle/)
    expect(rendered).not_to match(/Location/)
    expect(rendered).to match(/Date/)
  end
end
