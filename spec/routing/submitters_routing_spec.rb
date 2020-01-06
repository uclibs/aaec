# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SubmittersController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/submitters').to route_to('submitters#index')
    end

    it 'routes to #new' do
      expect(get: '/submitters/new').to route_to('submitters#new')
    end

    it 'routes to #show' do
      expect(get: '/submitters/1').to route_to('submitters#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/submitters/1/edit').to route_to('submitters#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/submitters').to route_to('submitters#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/submitters/1').to route_to('submitters#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/submitters/1').to route_to('submitters#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/submitters/1').to route_to('submitters#destroy', id: '1')
    end
  end
end
