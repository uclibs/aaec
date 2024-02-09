# frozen_string_literal: true

# The SubmitterOwnershipGuard module is a concern for Rails controllers that provides
# functionality to restrict access to resources based on the submitter's identity.
# It defines a set of before actions to check if the current user (submitter) is authorized
# to access a given resource. This module handles special cases for submitters and ensures
# that access is granted only if the user's session matches the submitter_id associated
# with the resource. It's included in the publications and submitters controllers
#
# "Index" is skipped because it has its own logic to determine what can be shown.
module SubmitterOwnershipGuard
  extend ActiveSupport::Concern

  PAGES_VIEWABLE_BY_ALL = %w[errors pages].freeze

  included do
    before_action :verify_user_ownership, only: %i[show edit update destroy]
  end

  def verify_user_ownership
    return if user_is_admin? || page_viewable_by_all?

    deny_access unless current_submitter_is_owner?
  end

  private

  def page_viewable_by_all?
    PAGES_VIEWABLE_BY_ALL.include?(controller_name)
  end

  def current_submitter_is_owner?
    return submitter_owns_profile? if controller_name == 'submitters'

    submitter_owns_publication?
  end

  def submitter_owns_profile?
    submitter = Submitter.find_by(id: params[:id])

    submitter && (logged_in_submitter_id == submitter.id.to_s)
  end

  def submitter_owns_publication?
    publication = publication_class.find_by(id: params[:id])
    publication && (logged_in_submitter_id == publication.submitter_id.to_s)
  end

  def publication_class
    controller_name.classify.constantize
  end

  def deny_access
    raise ActiveRecord::RecordNotFound
  end

  def user_is_admin?
    session[:admin]
  end

  def logged_in_submitter_id
    session[:submitter_id].to_s
  end
end
