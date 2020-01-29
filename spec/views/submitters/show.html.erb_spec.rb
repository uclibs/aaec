# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'submitters/show', type: :view do
  before(:each) do
    @submitter = FactoryBot.create(:submitter)
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/First/)
    expect(rendered).to match(/Last/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Department/)
    expect(rendered).to match(/Home Address/)
    expect(rendered).to match(/111-111-1111/)
    expect(rendered).to match(/test@mail.uc.edu/)
  end
end
