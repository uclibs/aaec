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
# - check_max_submissions: Checks if the maximum submission limit is reached for a given user.
#

class PublicationsController < ApplicationController
  rescue_from StandardError, with: :handle_standard_error
  rescue_from NameError, with: :handle_name_error

  before_action :set_object, only: %i[show edit update destroy]
  before_action :check_max_submissions, only: %i[new]

  RESOURCE_NAMES = %i[
    artworks books book_chapters digital_projects editings
    films journal_articles musical_scores photographies
    physical_media public_performances plays other_publications
  ].freeze

  def index
    puts "***Admin session: #{session[:admin]}***"
    redirect_to publications_path unless request.path.include? publications_path

    if session[:admin]
      load_admin_resources
    else
      load_submitter_resources
    end
  end

  def show
    @submitter = helpers.find_submitter(instance_variable_get("@#{controller_name.singularize}").id) if session[:admin]
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
        flash.keep[:success] = "#{controller_name.classify} was successfully created."
        format.html { redirect_to publications_path }
        format.json { render :show, status: :created, location: instance_variable }
      else
        format.html { render :new }
        format.json { render json: instance_variable.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    instance_variable = instance_variable_get("@#{controller_name.singularize}")
    respond_to do |format|
      if instance_variable.update(allowed_params)
        puts "update successful"
        flash.keep[:success] = "#{controller_name.classify} was successfully updated."
        format.html { redirect_to instance_variable }
        format.json { render :show, status: :created, location: instance_variable }
      else
        puts "update failed"
        format.html { render :edit }
        format.json { render json: instance_variable.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    instance_variable = instance_variable_get("@#{controller_name.singularize}")
    instance_variable.destroy
    respond_to do |format|
      flash.keep[:warning] = "#{controller_name.classify} was successfully destroyed."
      format.html { redirect_to publications_url }
      format.json { head :no_content }
    end
  end

  protected

  def set_object
    instance_variable_set("@#{controller_name.singularize}", Object.const_get(controller_name.classify).find(params[:id]))
  end

  def check_max_submissions
    redirect_to publications_path if Object.const_get(controller_name.classify).where(submitter_id: session[:submitter_id]).count > 2
  end

  private

  def load_admin_resources
    puts "in load_admin_resources"
    if params[:id].nil?
      load_all_resources_for_admin
    else
      load_single_submitter_resources_for_admin(params[:id])
    end
  end

  def load_all_resources_for_admin
    puts 'in load_all_resources_for_admin'
    RESOURCE_NAMES.each do |resource_name|
      load_resource_for_admin(resource_name)
    end
    instance_variable_set('@submitter_count', Submitter.all.count)
  end

  def load_resource_for_admin(resource_name)
    puts "in load_resource_for_admin for #{resource_name}"
    model_class = resource_name.to_s.classify.constantize
    puts "where model_class is #{model_class}"
    pagy_variable, records = pagy(model_class.all, page_param: :"page_#{resource_name}")
    instance_variable_set("@pagy_#{resource_name}", pagy_variable)
    puts "@pagy_#{resource_name}: #{pagy_variable}"
    instance_variable_set("@#{resource_name}", records)
    puts "@#{resource_name}: #{records}"
    instance_variable_set("@#{resource_name}_count", records.count)
    puts "@#{resource_name}_count: #{records.count}"
  end

  def load_single_submitter_resources_for_admin(submitter_id)
    puts "in load_single_submitter_resources_for_admin"
    RESOURCE_NAMES.each do |resource_name|
      records = helpers.send("find_#{resource_name}", submitter_id)
      instance_variable_set("@#{resource_name}", records)
      instance_variable_set("@#{resource_name}_count", records.count)
    end
    @submitter = helpers.find_submitter(submitter_id)
  end

  def load_submitter_resources
    puts "in load_submitter_resources"
    redirect_to publications_path if params[:id]
    submitter_id = session[:submitter_id]

    RESOURCE_NAMES.each do |resource_name|
      instance_variable_set("@#{resource_name}", helpers.send("find_#{resource_name}", submitter_id))
    end
    @submitter = helpers.find_submitter(submitter_id)
  end

  def handle_standard_error(err)
    puts "in handle_standard_error, with message: #{err.message}"
    Rails.logger.error("Failed to load resources: #{err.message}")
    raise ActionController::RoutingError, 'Not Found'
  end

  def handle_name_error(err)
    puts "in handle_name_error, with message: #{err.message}"
    Rails.logger.error "Invalid resource name: #{err.message}"
    raise ActionController::RoutingError, 'Not Found'
  end
end
