# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BookChaptersController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/book_chapters').to route_to('book_chapters#index')
    end

    it 'routes to #new' do
      expect(get: '/book_chapters/new').to route_to('book_chapters#new')
    end

    it 'routes to #show' do
      expect(get: '/book_chapters/1').to route_to('book_chapters#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/book_chapters/1/edit').to route_to('book_chapters#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/book_chapters').to route_to('book_chapters#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/book_chapters/1').to route_to('book_chapters#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/book_chapters/1').to route_to('book_chapters#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/book_chapters/1').to route_to('book_chapters#destroy', id: '1')
    end
  end
end
