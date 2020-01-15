# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OtherPublicationsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/other_publications').to route_to('other_publications#index')
    end

    it 'routes to #new' do
      expect(get: '/other_publications/new').to route_to('other_publications#new')
    end

    it 'routes to #show' do
      expect(get: '/other_publications/1').to route_to('other_publications#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/other_publications/1/edit').to route_to('other_publications#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/other_publications').to route_to('other_publications#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/other_publications/1').to route_to('other_publications#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/other_publications/1').to route_to('other_publications#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/other_publications/1').to route_to('other_publications#destroy', id: '1')
    end
  end
end
