# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'films/show', type: :view do
  before(:each) do
    @film = FactoryBot.create(:film)
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/First/)
    expect(rendered).to match(/Last/)
    expect(rendered).to match(/Arts and Sciences/)
    expect(rendered).to match(/Department/)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Subtitle/)
    expect(rendered).to match(/Director/)
    expect(rendered).to match(/Release year/)
  end
end
