# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :check_date

  private

  def check_date
    @expiration_date = Date.new(2020, 7, 15)
    redirect_to helpers.page_route("closed") if @expiration_date.past? unless session[:admin] == true
  end
end
