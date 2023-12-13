# frozen_string_literal: true

# The RestrictSubmitterAccess module is a concern for Rails controllers that provides
# functionality to restrict access to resources based on the submitter's identity.
# It defines a set of before actions to check if the current user (submitter) is authorized
# to access a given resource. This module handles special cases for submitters and ensures
# that access is granted only if the user's session matches the submitter_id associated
# with the resource. It's included in the application controller and is skipped for
# controllers that don't require submitter authentication (e.g. pages, errors, etc.).
#
# "Index" is skipped because it has its own logic to determine what can be shown.
module RestrictSubmitterAccess
  extend ActiveSupport::Concern

  included do
    before_action :restrict_submitter_access, except: %i[index new create login validate finished]
  end

  private

  def restrict_submitter_access
    return if session[:admin] || non_submitter_controller?

    if controller_name == 'submitters'
      handle_submitter_special_case
      return
    end

    set_resource
    unauthorized_access unless authorized_submitter?
  end

  def non_submitter_controller?
    return true if controller_name == 'admin'

    %w[errors pages].include? controller_name
  end

  def handle_submitter_special_case
    submitter = Submitter.find(params[:id])
    unauthorized_access if session[:submitter_id] != submitter.id
  end

  def set_resource
    return unless resource_class.method_defined?(:submitter_id)

    @resource = resource_class.find(params[:id])
  end

  def resource_class
    controller_name.classify.constantize
  end

  def authorized_submitter?
    @resource && (session[:submitter_id].to_s == @resource.submitter_id.to_s)
  end

  def unauthorized_access
    raise ActiveRecord::RecordNotFound
  end
end
