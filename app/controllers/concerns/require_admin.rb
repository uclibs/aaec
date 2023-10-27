# frozen_string_literal: true

# The RequireAdminAuthentication module is a Rails concern that provides a before_action
# to restrict access to pages to administrators only.
#
# This module should be included in any controllers where the actions should only be
# accessible by an administrator.
#
# == Usage
# Include this module at the top of any controllers that require admin authentication.
# The module will add a `before_action` to the controller, which checks whether the
# admin is logged in by looking at `session[:admin]`.
#
# If an admin is not logged in, the user will be redirected to the 404 page. (Security
# through obscurity.)
#
# == Example
#
#   class AdminController < ApplicationController
#     include RequireAdminAuthentication
#     # ... rest of the code
#   end
#
module RequireAdmin
  extend ActiveSupport::Concern

  included do
    before_action :check_admin
  end

  private

  def check_admin
    return if session[:admin]

    render template: 'errors/404', status: :not_found
  end
end
