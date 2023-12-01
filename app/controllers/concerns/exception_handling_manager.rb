# frozen_string_literal: true

# ExceptionHandlingManager is a concern designed to centralize and manage
# the handling of various application-specific exceptions.
#
# Currently, it includes handling for:
# - ActionController::InvalidAuthenticityToken
#
# Future additions may include but are not limited to:
# - RecordNotFound
# - TimeoutErrors
# - CustomApplicationErrors
#
# This concern is included in the ApplicationController, so all controllers inherit
module ExceptionHandlingManager
  extend ActiveSupport::Concern

  included do
    rescue_from ActionController::InvalidAuthenticityToken, with: :handle_invalid_token
  end

  private

  def handle_invalid_token(exception)
    Rails.logger.warn("InvalidAuthenticityToken occurred: #{exception}")
    reset_session
    flash.keep[:danger] = 'Your session has expired. Please log in again.'
    redirect_to root_path
  end
end
