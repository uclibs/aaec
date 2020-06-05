# frozen_string_literal: true

class AdminController < ApplicationController
  def login; end

  def validate
    if check_credentials(params[:username], params[:password])
      session[:admin] = true
      redirect_to publications_path
    else
      redirect_to manage_path, notice: 'Invalid Credentails'
    end
  end

  def csv
    if session[:admin] && params[:id].nil?
      instance_variable_set('@instance_variable', Object.const_get(params[:controller_name].classify).all)
      respond_to do |format|
        format.html { redirect_to publications_path }
        format.csv { send_data @instance_variable.to_csv }
      end
    else
      redirect_to publications_path
    end
  end

  private

  def check_credentials(username, password)
    username == ENV['ADMIN_USERNAME'] && password == ENV['ADMIN_PASSWORD']
  end
end
