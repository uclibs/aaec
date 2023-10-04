# frozen_string_literal: true

# spec/routing/error_pages_routing_spec.rb

require 'rails_helper'

RSpec.describe 'Error Pages', type: :routing do
  %w[get post put patch delete].each do |http_method|
    it "routes /404 to errors#not_found for #{http_method.upcase}" do
      expect({ http_method.to_s => '/404' }).to route_to(controller: 'errors', action: 'not_found')
    end

    it "routes /500 to errors#internal_server_error for #{http_method.upcase}" do
      expect({ http_method.to_s => '/500' }).to route_to(controller: 'errors', action: 'internal_server_error')
    end

    it "routes /422 to errors#unprocessable_entity for #{http_method.upcase}" do
      expect({ http_method.to_s => '/422' }).to route_to(controller: 'errors', action: 'unprocessable_entity')
    end
  end
end
