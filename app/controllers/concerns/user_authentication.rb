# frozen_string_literal: true

# UserAuthentication Module
#
# This ActiveSupport::Concern module is designed to be included in Rails controllers
# to provide user authentication features. Once included, it automatically adds
# before actions to enforce user authentication.
#
# ## Usage
#
# To use this module, include it at the top of any Rails controller where you
# want to enforce user authentication:
#
# Example:
#   class SomeController < ApplicationController
#     include UserAuthentication
#     ...
#   end
#
#
# This will add the following before actions to the controller:
# - `require_authenticated_user`: Ensures that a user is authenticated.
#
#
module UserAuthentication
  extend ActiveSupport::Concern

  included do
    rescue_from ActionController::InvalidAuthenticityToken, with: :handle_invalid_token
    before_action :require_authenticated_user
  end

  private

  def handle_invalid_token
    reset_session
    flash.keep[:danger] = 'Your session has expired. Please log in again.'
    redirect_to root_path
  end

  def require_authenticated_user
    return if admin_logged_in? || current_submitter

    flash.keep[:danger] = 'You must submit your information first.'
    redirect_to root_path
  end

  def admin_logged_in?
    session[:admin]
  end

  def current_submitter
    @current_submitter ||= Submitter.find_by(id: session[:submitter_id])
  end
end
