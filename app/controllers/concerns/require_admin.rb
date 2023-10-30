# frozen_string_literal: true

# The RequireAdminAuthentication module is a Rails concern aimed at restricting
# access to pages solely to administrators.
#
# To use this concern, include it in controllers where only admins should have access.
#
# == Usage
# Include the module in the controller to automatically add a `before_action`
# that checks for admin status via `session[:admin]`.
#
# If an admin is not logged in, the user is redirected to a 404 page for security.
#
# == Example
#
#   class AdminController < ApplicationController
#     include RequireAdminAuthentication
#     # ... other code
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
