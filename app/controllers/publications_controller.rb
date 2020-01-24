# frozen_string_literal: true

class PublicationsController < ApplicationController
  before_action :set_object, only: %i[show edit update destroy]
  before_action :signed_in, only: %i[index show edit update destroy]
  before_action :check_max_submissions, only: %i[new]

  def index
    redirect_to publications_path if request.fullpath != '/publications'
    @submitters = helpers.find_submitter(session[:submitter_id])
    @books = helpers.find_books(session[:submitter_id])
    @other_publications = helpers.find_other_publications(session[:submitter_id])
  end

  def show; end

  def new
    instance_variable_set("@#{controller_name.singularize}", Object.const_get(controller_name.classify).new)
  end

  def edit; end

  def create
    instance_variable_set("@#{controller_name.singularize}", Object.const_get(controller_name.classify).new(allowed_params))
    instance_variable = instance_variable_get("@#{controller_name.singularize}")
    respond_to do |format|
      if instance_variable.save
        format.html { redirect_to publications_path, notice: "#{controller_name.classify} was successfully created." }
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
        format.html { redirect_to instance_variable, notice: "#{controller_name.classify} was successfully updated." }
        format.json { render :show, status: :created, location: instance_variable }
      else
        format.html { render :new }
        format.json { render json: instance_variable.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    instance_variable = instance_variable_get("@#{controller_name.singularize}")
    instance_variable.destroy
    respond_to do |format|
      format.html { redirect_to instance_variable, notice: "#{controller_name.classify} was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  protected

  def set_object
    instance_variable_set("@#{controller_name.singularize}", Object.const_get(controller_name.classify).find(params[:id]))
  end

  def signed_in
    redirect_to new_submitter_path if session[:submitter_id].nil?
  end

  def check_max_submissions
    redirect_to publications_path if Object.const_get(controller_name.classify).where(submitter_id: session[:submitter_id]).count > 2
  end
end
