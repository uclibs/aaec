# frozen_string_literal: true

# == Schema Information
#
# Controller: PublicationsController
#
# Overview:
# The PublicationsController handles the CRUD operations for various types of
# publications like Artwork, Book, BookChapter, and so on. It is designed to
# handle submissions from both admin and regular users.
#
# Responsibilities:
# - Filtering requests based on the logged-in user type (Admin or regular user)
# - Managing CRUD operations for multiple publication types
# - Sending notifications via PublicationMailer upon successful publication submission
# - Redirecting based on various conditions such as user session and max submissions
#
# Special Behaviors:
# - Utilizes dynamic setting of instance variables and object types
# - Makes extensive use of helpers for finding records
#
# Filters:
# - set_object: Sets the object based on the controller name and params[:id].
# - signed_in: Checks if the user is signed in before granting access to certain actions.
# - check_max_submissions: Checks if the maximum submission limit is reached for a given user.
#

class PublicationsController < ApplicationController
  include SubmitterOwnershipGuard

  before_action :set_object, only: %i[show edit update destroy]
  before_action :signed_in, only: %i[index show edit update destroy]
  before_action :check_max_submissions, only: %i[new]

  RESOURCE_NAMES = %i[
    artworks books book_chapters digital_projects editings
    films journal_articles musical_scores photographies
    physical_media public_performances plays other_publications
  ].freeze

  def index
    redirect_to publications_path unless request.path.include? publications_path

    if session[:admin]
      load_admin_resources
    else
      load_submitter_resources
    end
  end

  def show
    return unless session[:admin]

    resource = controller_name.singularize
    resource_instance = instance_variable_get("@#{resource}")

    raise ActiveRecord::RecordNotFound unless resource_instance

    @submitter = helpers.find_submitter(resource_instance.id)
  end

  def new
    instance_variable_set("@#{controller_name.singularize}", Object.const_get(controller_name.classify).new)
  end

  def edit; end

  def create
    instance_variable_set("@#{controller_name.singularize}", Object.const_get(controller_name.classify).new(allowed_params))
    instance_variable = instance_variable_get("@#{controller_name.singularize}")
    respond_to do |format|
      if instance_variable.save
        PublicationMailer.publication_submit(helpers.find_submitter(session[:submitter_id]), instance_variable).deliver_now
        class_name = controller_name.classify
        formatted_name = class_name.underscore.humanize.titleize
        flash.keep[:success] = "#{formatted_name} was successfully created."
        format.html { redirect_to publications_path }
        format.json { render :show, status: :created, location: instance_variable }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: instance_variable.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    instance_variable = instance_variable_get("@#{controller_name.singularize}")
    respond_to do |format|
      if instance_variable.update(allowed_params)
        class_name = controller_name.classify
        formatted_name = class_name.underscore.humanize.titleize
        flash.keep[:success] = "#{formatted_name} was successfully updated."
        format.html { redirect_to instance_variable }
        format.json { render :show, status: :created, location: instance_variable }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: instance_variable.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    instance_variable = instance_variable_get("@#{controller_name.singularize}")
    instance_variable.destroy
    respond_to do |format|
      class_name = controller_name.classify
      formatted_name = class_name.underscore.humanize.titleize
      flash.keep[:warning] = "#{formatted_name} was successfully destroyed."
      format.html { redirect_to publications_path }
      format.json { head :no_content }
    end
  end

  protected

  def set_object
    instance_variable_set("@#{controller_name.singularize}", Object.const_get(controller_name.classify).find_by(id: params[:id]))
  end

  def signed_in
    redirect_to root_path unless session[:admin] || session[:submitter_id]
  end

  def check_max_submissions
    redirect_to publications_path if Object.const_get(controller_name.classify).where(submitter_id: session[:submitter_id]).count > 2
  end

  private

  def load_admin_resources
    if params[:id].nil?
      load_all_resources_for_admin
    else
      load_single_submitter_resources_for_admin(params[:id])
    end
  end

  def load_all_resources_for_admin
    RESOURCE_NAMES.each do |resource_name|
      load_resource_for_admin(resource_name)
    end
    @pagy_submitters, @submitters = pagy(Submitter.all, page_param: :page_submitters)
    @submitter_count = Submitter.all.count
  end

  def load_resource_for_admin(resource_name)
    model_class = resource_name.to_s.classify.constantize
    pagy_variable, records = pagy(model_class.all, page_param: :"page_#{resource_name}")
    instance_variable_set("@pagy_#{resource_name}", pagy_variable)
    instance_variable_set("@#{resource_name}", records)
    singular_resource_name = resource_name.to_s.singularize
    instance_variable_set("@#{singular_resource_name}_count", model_class.count)
  end

  def load_single_submitter_resources_for_admin(submitter_id)
    RESOURCE_NAMES.each do |resource_name|
      records = helpers.send("find_#{resource_name}", submitter_id)
      instance_variable_set("@#{resource_name}", records)
      singular_resource_name = resource_name.to_s.singularize
      instance_variable_set("@#{singular_resource_name}_count", records.count)
    end
    @submitter = helpers.find_submitter(submitter_id)
  end

  def load_submitter_resources
    redirect_to publications_path if params[:id]
    submitter_id = session[:submitter_id]

    RESOURCE_NAMES.each do |resource_name|
      instance_variable_set("@#{resource_name}", helpers.send("find_#{resource_name}", submitter_id))
    end
    @submitter = helpers.find_submitter(submitter_id)
  end
end
