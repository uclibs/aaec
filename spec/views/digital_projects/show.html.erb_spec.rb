# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'digital_projects/show', type: :view do
  before(:each) do
    @digital_project = FactoryBot.create(:digital_project)
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/First/)
    expect(rendered).to match(/Last/)
    expect(rendered).to match(/Arts and Sciences/)
    expect(rendered).to match(/Department/)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Subtitle/)
    expect(rendered).to match(/Name of site/)
    expect(rendered).to match(/Name of affiliated organization/)
    expect(rendered).to match(/Publication Date/)
    expect(rendered).to match(/URL/)
    expect(rendered).to match(/DOI/)
  end
end
