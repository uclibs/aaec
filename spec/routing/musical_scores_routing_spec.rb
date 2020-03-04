# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BookChaptersController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/musical_scores').to route_to('musical_scores#index')
    end

    it 'routes to #new' do
      expect(get: '/musical_scores/new').to route_to('musical_scores#new')
    end

    it 'routes to #show' do
      expect(get: '/musical_scores/1').to route_to('musical_scores#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/musical_scores/1/edit').to route_to('musical_scores#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/musical_scores').to route_to('musical_scores#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/musical_scores/1').to route_to('musical_scores#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/musical_scores/1').to route_to('musical_scores#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/musical_scores/1').to route_to('musical_scores#destroy', id: '1')
    end
  end
end
