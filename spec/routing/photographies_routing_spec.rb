# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PhotographiesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/photographies').to route_to('photographies#index')
    end

    it 'routes to #new' do
      expect(get: '/photographies/new').to route_to('photographies#new')
    end

    it 'routes to #show' do
      expect(get: '/photographies/1').to route_to('photographies#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/photographies/1/edit').to route_to('photographies#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/photographies').to route_to('photographies#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/photographies/1').to route_to('photographies#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/photographies/1').to route_to('photographies#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/photographies/1').to route_to('photographies#destroy', id: '1')
    end
  end
end
