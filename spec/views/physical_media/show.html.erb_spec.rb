# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'physical_media/show', type: :view do
  before(:each) do
    @physical_medium = FactoryBot.create(:physical_medium)
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/First/)
    expect(rendered).to match(/Last/)
    expect(rendered).to match(/Arts and Sciences/)
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
