# frozen_string_literal: true

# The UserAuthentication module is a Rails concern designed to enforce user
# authentication across all controllers in the application. It is included
# in ApplicationController by default.
#
# == Functionality
# The concern provides a `before_action` hook named `require_authenticated_user`,
# which checks for authenticated users by looking at whether an admin or a
# submitter is currently logged in. If neither is true, the user is redirected
# to the root path.
#
# Utility methods `admin_logged_in?` and `current_submitter` assist in this check.
#
# == Usage Note
# The `before_action` should be skipped for controllers or actions handling
# login features.
#
module UserAuthentication
  extend ActiveSupport::Concern

  included do
    before_action :require_authenticated_user
  end

  private

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
