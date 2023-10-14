# frozen_string_literal: true

# UserAuthentication Module
#
# This module is intended to be included in controllers that require
# user authentication and admin check functionalities.
#
# It adds a `before_action` that ensures a user is authenticated as either
# an admin or a regular submitter before accessing any action in the
# controller.
#
# Example:
#   class SomeController < ApplicationController
#     include UserAuthentication
#     ...
#   end
#
module UserAuthentication
  extend ActiveSupport::Concern

  included do
    before_action :require_authenticated_user
    before_action :set_cache_headers
  end

  private

  def require_authenticated_user
    return if admin_logged_in? || current_submitter

    redirect_to root_path, alert: 'You must submit your information first.'
  end

  def admin_logged_in?
    session[:admin]
  end

  def current_submitter
    @current_submitter ||= Submitter.find_by(id: session[:submitter_id])
  end

  def set_cache_headers
    response.headers['Cache-Control'] = 'no-cache, no-store, max-age=0, must-revalidate'
    response.headers['Pragma'] = 'no-cache'
    response.headers['Expires'] = 'Fri, 01 Jan 1990 00:00:00 GMT'
  end
end
