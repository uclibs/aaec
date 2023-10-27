# frozen_string_literal: true

# UserAuthentication is a concern included in ApplicationController,
# and it therefore applies across all controllers in the application.
# It defines a before_action hook that requires a user to be authenticated
# in order to access any controller action.
#
# The `require_authenticated_user` method checks if a user is authenticated.
# It does so by checking either if an admin is logged in
# or if a submitter is currently set. If neither condition is true, the user is
# redirected to the root path.
#
# The methods `admin_logged_in?` and `current_submitter` are utility methods
# used within `require_authenticated_user` to check for authenticated users.
#
# Note: The before_action should be skipped for routes that manage login
# functionalities.
#
module UserAuthentication
  extend ActiveSupport::Concern

  included do
    before_action :require_authenticated_user
  end

  private

  def require_authenticated_user
    puts "in require_authenticated_user"
    return if admin_logged_in? || current_submitter
    puts "and neither admin nor current submitter is present"
    flash.keep[:danger] = 'You must submit your information first.'
    redirect_to root_path
  end

  def admin_logged_in?
    puts "in admin_logged_in?"
    puts "session[:admin]?: #{session[:admin]==true}"
    session[:admin]
  end

  def current_submitter
    puts "in current_submitter"
    puts "session[:submitter_id]: #{session[:submitter_id]}"
    puts @current_submitter ||= Submitter.find_by(id: session[:submitter_id])
    @current_submitter ||= Submitter.find_by(id: session[:submitter_id])
  end
end
