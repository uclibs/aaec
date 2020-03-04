# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BookChaptersController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/public_performances').to route_to('public_performances#index')
    end

    it 'routes to #new' do
      expect(get: '/public_performances/new').to route_to('public_performances#new')
    end

    it 'routes to #show' do
      expect(get: '/public_performances/1').to route_to('public_performances#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/public_performances/1/edit').to route_to('public_performances#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/public_performances').to route_to('public_performances#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/public_performances/1').to route_to('public_performances#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/public_performances/1').to route_to('public_performances#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/public_performances/1').to route_to('public_performances#destroy', id: '1')
    end
  end
end
