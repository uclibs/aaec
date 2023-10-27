# frozen_string_literal: true

# RestrictSubmitterAccess is a Rails concern that enforces access controls
# on controller actions based on the user's role and ownership of resources.
# It is included in the application controller, and therefore applies to all controllers.
# It is intended to be used in conjunction with the UserAuthentication concern,
# and should be included after the UserAuthentication concern.
#
# For controllers dealing with models that have a `submitter_id` attribute,
# this concern will restrict access to actions other than `:index`, `:new`, and `:create`,
# unless the logged-in user is the submitter who owns the resource.
# If an admin is logged in, these restrictions are bypassed.
#
# For the special case of the `SubmittersController`, this concern checks
# if the logged-in user is the same as the user corresponding to the `:id` parameter.
#
# == Note
# This concern assumes that `session[:submitter_id]` is used to store the logged-in submitter's ID,
# and that `session[:admin]` is used to identify logged-in admins.
module RestrictSubmitterAccess
  extend ActiveSupport::Concern

  included do
    before_action :restrict_submitter_access, except: %i[index new create login validate finished]
  end

  private

  def restrict_submitter_access
    return if session[:admin]

    if controller_name == 'submitters'
      handle_submitter_special_case
      return
    end

    return unless resource_has_submitter_id?

    unauthorized_access unless authorized_submitter?
  end

  def handle_submitter_special_case
    resource = Submitter.find(params[:id])
    unauthorized_access if session[:submitter_id] != resource.id
  end

  def resource_has_submitter_id?
    model = controller_name.classify.constantize
    @resource = model.find(params[:id])
    # @resource = model.find(params[:id])
    @resource.respond_to?(:submitter_id)
  end

  def authorized_submitter?
    session[:submitter_id] == @resource.submitter_id.to_i
  end

  def unauthorized_access
    raise ActiveRecord::RecordNotFound
  end
end
