# frozen_string_literal: true

class SubmittersController < ApplicationController
  include UserAuthentication
  skip_before_action :require_authenticated_user, only: %i[new create]
  skip_before_action :set_cache_headers, only: %i[new create]

  before_action :set_submitter, only: %i[show edit update destroy]

  # GET /submitters/1
  # GET /submitters/1.json
  def show; end

  # GET /submitters/new
  def new
    @submitter = Submitter.new
  end

  # GET /submitters/1/edit
  def edit; end

  # POST /submitters
  # POST /submitters.json
  def create
    @submitter = Submitter.new(submitter_params)

    respond_to do |format|
      if @submitter.save
        session[:submitter_id] = @submitter.id
        # Change to home page
        format.html { redirect_to publications_path, notice: 'Your account was successfully created.' }
        format.json { render :show, status: :created, location: @submitter }
      else
        format.html { render :new }
        format.json { render json: @submitter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /submitters/1
  # PATCH/PUT /submitters/1.json
  def update
    respond_to do |format|
      if @submitter.update(submitter_params)
        format.html { redirect_to publications_path, notice: 'Your account was successfully updated.' }
        format.json { render :show, status: :ok, location: @submitter }
      else
        format.html { render :edit }
        format.json { render json: @submitter.errors, status: :unprocessable_entity }
      end
    end
  end

  def finished
    admin = session[:admin]
    reset_session
    if admin.nil?
      render 'pages/finished'
    else
      redirect_to root_path
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_submitter
    @submitter = Submitter.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def submitter_params
    params.require(:submitter).permit(:first_name, :last_name, :department, :mailing_address, :phone_number, :email_address, :college)
  end
end
