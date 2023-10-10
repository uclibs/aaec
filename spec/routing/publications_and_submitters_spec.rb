# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Publications and Submitters Routes', type: :routing do
  describe 'GET #publications' do
    it 'routes to publications#index' do
      expect(get: '/publications').to route_to('publications#index')
    end
  end

  describe 'GET #publications/:id' do
    it 'routes to publications#index with an ID' do
      expect(get: '/publications/1').to route_to('publications#index', id: '1')
    end
  end

  describe 'GET #finished' do
    it 'routes to submitters#finished' do
      expect(get: '/finished').to route_to('submitters#finished')
    end
  end
end
