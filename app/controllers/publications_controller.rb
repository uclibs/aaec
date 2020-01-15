# frozen_string_literal: true

class PublicationsController < ApplicationController
  def index
    instance_variable_set("@#{controller_name.pluralize}", Object.const_get(controller_name.classify).all)
  end

  def show; end

  def new
    redirect_to new_submitter_path if session[:submitter_id].nil?
    instance_variable_set("@#{controller_name.singularize}", Object.const_get(controller_name.classify).new)
  end

  def edit; end

  def create
    instance_variable_set("@#{controller_name.singularize}", Object.const_get(controller_name.classify).new(allowed_params))
    instance_variable = instance_variable_get("@#{controller_name.singularize}")
    respond_to do |format|
      if instance_variable.save
        format.html { redirect_to instance_variable, notice: "#{controller_name.classify} was successfully created." }
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
end
