# spec/controllers/concerns/cache_header_control_spec.rb

require 'rails_helper'

RSpec.describe CacheHeaderControl, type: :controller do
  # Create a dummy controller that includes the concern
  controller(ApplicationController) do
    include CacheHeaderControl

    def index
      render plain: 'ok'
    end
  end

  describe 'Cache headers' do
    before do
      routes.draw { get 'index', to: 'anonymous#index' }
    end

    it 'sets Cache-Control header' do
      get :index
      puts response.headers
      expect(response.headers['Cache-Control']).to eq('no-cache, no-store, max-age=0, must-revalidate')
    end

    # it 'sets Pragma header' do
    #   get :index
    #   expect(response.headers['Pragma']).to eq('no-cache')
    # end

    # it 'sets Expires header' do
    #   get :index
    #   expect(response.headers['Expires']).to eq('Fri, 01 Jan 1990 00:00:00 GMT')
    # end
  end
end
