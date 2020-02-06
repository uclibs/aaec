# frozen_string_literal: true

class AdminController < ApplicationController
  def login; end

  def validate
    if check_credentials(params[:username], params[:password])
      session[:admin] = true
      redirect_to publications_path, notice: 'Valid Credentails'
    else
      redirect_to admin_path, notice: 'Invalid Credentails'
    end
  end

  private

  def check_credentials(username, password)
    username == ENV['ADMIN_USERNAME'] && password == ENV['ADMIN_PASSWORD']
  end
end
