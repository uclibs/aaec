# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PagesController, type: :routing do
  describe 'routing' do
    it 'routes to #show with about as parameter' do
      expect(get: '/pages/about').to route_to('pages#show', page: 'about')
    end

    it 'routes to #show with contact as parameter' do
      expect(get: '/pages/contact').to route_to('pages#show', page: 'contact')
    end

    it 'routes to #show with faq as parameter' do
      expect(get: '/pages/faq').to route_to('pages#show', page: 'faq')
    end

    it 'does not route to #show without a page parameter' do
      expect(get: '/pages/').not_to be_routable
    end
  end
end
