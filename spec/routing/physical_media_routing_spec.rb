# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BookChaptersController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/physical_media').to route_to('physical_media#index')
    end

    it 'routes to #new' do
      expect(get: '/physical_media/new').to route_to('physical_media#new')
    end

    it 'routes to #show' do
      expect(get: '/physical_media/1').to route_to('physical_media#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/physical_media/1/edit').to route_to('physical_media#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/physical_media').to route_to('physical_media#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/physical_media/1').to route_to('physical_media#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/physical_media/1').to route_to('physical_media#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/physical_media/1').to route_to('physical_media#destroy', id: '1')
    end
  end
end
