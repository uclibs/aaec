# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BookChaptersController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/digital_projects').to route_to('digital_projects#index')
    end

    it 'routes to #new' do
      expect(get: '/digital_projects/new').to route_to('digital_projects#new')
    end

    it 'routes to #show' do
      expect(get: '/digital_projects/1').to route_to('digital_projects#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/digital_projects/1/edit').to route_to('digital_projects#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/digital_projects').to route_to('digital_projects#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/digital_projects/1').to route_to('digital_projects#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/digital_projects/1').to route_to('digital_projects#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/digital_projects/1').to route_to('digital_projects#destroy', id: '1')
    end
  end
end
