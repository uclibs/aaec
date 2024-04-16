# frozen_string_literal: true

# The UserAuthentication module provides mechanisms to enforce user authentication
# for actions in controllers where it is included. It utilizes ActiveSupport::Concern
# to add a before_action hook that checks for authenticated users (either admin or submitter)
# before allowing access to controller actions. Unauthenticated users are redirected
# to the root path with an appropriate warning message.
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
