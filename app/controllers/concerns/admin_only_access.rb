# frozen_string_literal: true

# AdminOnlyAccess provides a mechanism to restrict access to certain
# controller actions to admin users only. It hooks into the controller's
# lifecycle using a before_action to check the user's admin status.
module AdminOnlyAccess
  extend ActiveSupport::Concern

  included do
    before_action :check_admin
  end

  private

  def check_admin
    return if session[:admin]

    raise ActiveRecord::RecordNotFound
  end
end
