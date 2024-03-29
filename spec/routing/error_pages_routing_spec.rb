# frozen_string_literal: true

require 'rails_helper'

# per Infosec, all errors should route to the 404 page, not the 422 or 500 pages
RSpec.describe 'Error Pages', type: :routing do
  %w[get post put patch delete].each do |http_method|
    it "routes /404 to errors#not_found for #{http_method.upcase}" do
      expect({ http_method.to_s => '/404' }).to route_to(controller: 'errors', action: 'not_found')
    end

    it "routes /500 to errors#internal_server_error for #{http_method.upcase}" do
      expect({ http_method.to_s => '/500' }).to route_to(controller: 'errors', action: 'not_found')
    end

    it "routes /422 to errors#unprocessable_entity for #{http_method.upcase}" do
      expect({ http_method.to_s => '/422' }).to route_to(controller: 'errors', action: 'not_found')
    end
  end
end
