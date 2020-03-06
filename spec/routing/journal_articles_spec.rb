# frozen_string_literal: true

require 'rails_helper'

RSpec.describe JournalArticlesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/journal_articles').to route_to('journal_articles#index')
    end

    it 'routes to #new' do
      expect(get: '/journal_articles/new').to route_to('journal_articles#new')
    end

    it 'routes to #show' do
      expect(get: '/journal_articles/1').to route_to('journal_articles#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/journal_articles/1/edit').to route_to('journal_articles#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/journal_articles').to route_to('journal_articles#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/journal_articles/1').to route_to('journal_articles#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/journal_articles/1').to route_to('journal_articles#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/journal_articles/1').to route_to('journal_articles#destroy', id: '1')
    end
  end
end
