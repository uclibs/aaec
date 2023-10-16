# frozen_string_literal: true

# The CacheHeaderControl module is a Rails Concern designed to control the cache behavior
# of the HTTP responses from the controllers where it's included.
# This module sets specific HTTP headers to prevent the browser and any intermediate proxies
# from caching the response, ensuring that sensitive or dynamic data is not cached.
#
# Usage:
#
# Include this module in any Rails controller where you want to disable client-side caching.
# This will automatically add a before_action that sets appropriate cache control headers.
#
# Example:
#
# class SomeController < ApplicationController
#   include CacheHeaderControl
#   ...
# end
#
module CacheHeaderControl
  extend ActiveSupport::Concern

  included do
    before_action :set_cache_headers
  end

  private

  def set_cache_headers
    response.headers['Cache-Control'] = 'no-cache'
    response.headers['Pragma'] = 'no-cache'
    response.headers['Expires'] = 'Fri, 01 Jan 1990 00:00:00 GMT'
  end
end
