# frozen_string_literal: true

# The RestrictSubmitterAccess module is a Rails concern focused on limiting submitters'
# access to their own resources. This concern is included in ApplicationController,
# and thus is applied globally across controllers.
#
# It's designed to work alongside the UserAuthentication concern and should be
# included after it in the controller.
#
# == Functionality
# For controllers managing models with a `submitter_id`, access to actions other than
# `:index`, `:new`, and `:create` is restricted unless the user owns the resource.
# Admin users are exempt from these restrictions.
#
# The `SubmittersController` has special handling: this concern verifies that the
# logged-in user corresponds to the `:id` parameter in the route.
#
# == Assumptions
# - `session[:submitter_id]` stores the ID of the logged-in submitter.
# - `session[:admin]` identifies logged-in admins.
#
module RestrictSubmitterAccess
  extend ActiveSupport::Concern

  # Users must be allowed to log in without already being authenticated.  No
  # user-specific authentication is required to create a new publication.
  # The index action in PublicationsController has its own specific logic
  # for handling user access.
  included do
    before_action :restrict_submitter_access, except: %i[index new create login validate finished]
  end

  private

  def restrict_submitter_access
    return if session[:admin]

    # Errors and pages controllers are not associated with a submitter
    return if %w[errors pages].include? controller_name

    if controller_name == 'submitters'
      handle_submitter_special_case
      return
    end

    return unless resource_has_submitter_id?

    unauthorized_access unless authorized_submitter?
  end

  # Do not allow submitters to edit information about other submitters
  def handle_submitter_special_case
    resource = Submitter.find(params[:id])
    unauthorized_access if session[:submitter_id] != resource.id
  end

  def resource_has_submitter_id?
    model = controller_name.classify.constantize
    @resource = model.find(params[:id])
    @resource.respond_to?(:submitter_id)
  end

  def authorized_submitter?
    session[:submitter_id] == @resource.submitter_id.to_i
  end

  # Raise a 404 error if the user is not authorized to access the resource
  def unauthorized_access
    raise ActiveRecord::RecordNotFound
  end
end
