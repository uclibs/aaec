# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :check_date

  private

  def check_date
    @expiration_date = Date.parse(ENV.fetch('EXPIRATION_DATE'))
    redirect_to '/pages/closed' if @expiration_date.past?
  end
end
