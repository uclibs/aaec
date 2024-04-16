# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Root route', type: :routing do
  it 'routes the root URL to submitters#new' do
    expect(get: '/').to route_to(controller: 'submitters', action: 'new')
  end
end
