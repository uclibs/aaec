# frozen_string_literal: true

# The SubmitterOwnedContentGuard module is a concern for Rails controllers that provides
# functionality to restrict access to resources based on the submitter's identity.
# It defines a set of before actions to check if the current user (submitter) is authorized
# to access a given resource. This module handles special cases for submitters and ensures
# that access is granted only if the user's session matches the submitter_id associated
# with the resource. It's included in the application controller and is skipped for
# controllers that don't require submitter authentication (e.g. pages, errors, etc.).
#
# "Index" is skipped because it has its own logic to determine what can be shown.
module SubmitterOwnedContentGuard
  extend ActiveSupport::Concern

  included do
    before_action :verify_user_access, except: %i[index new create login validate finished]
  end

  pages_not_requiring_submitter_ownership = %w[errors pages]
  
  def verify_user_access
    return if user_is_admin? || no_submitter_linked_to_page?


    deny_access unless current_submitter_is_creator?
  end

  private

  def user_is_admin?
    session[:admin]
  end
  
  def no_submitter_linked_to_page?
    pages_not_requiring_submitter_ownership.include?(controller_name)
  end

  def handle_submitter_special_case
    submitter = Submitter.find(params[:id])
    unauthorized_access if session[:submitter_id] != submitter.id
  end

  def resource_class
    controller_name.classify.constantize
  end

  def current_submitter_is_creator?

    if controller_name == 'submitters'
      handle_submitter_special_case
      return
    end
    
    return unless resource_class.method_defined?(:submitter_id)

    resource = resource_class.find(params[:id])

    resource && (session[:submitter_id].to_s == resource.submitter_id.to_s)
  end

  def deny_access
    raise ActiveRecord::RecordNotFound
  end
end
