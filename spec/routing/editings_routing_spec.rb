# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EditingsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/editings').to route_to('editings#index')
    end

    it 'routes to #new' do
      expect(get: '/editings/new').to route_to('editings#new')
    end

    it 'routes to #show' do
      expect(get: '/editings/1').to route_to('editings#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/editings/1/edit').to route_to('editings#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/editings').to route_to('editings#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/editings/1').to route_to('editings#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/editings/1').to route_to('editings#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/editings/1').to route_to('editings#destroy', id: '1')
    end
  end
end
