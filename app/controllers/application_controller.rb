# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :check_date

  private

  def check_date
    @expiration_date = Date.new(2020, 5, 15)
    redirect_to '/pages/closed' if @expiration_date.past?
  end
end
