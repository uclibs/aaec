# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend
  include ExceptionHandlingManager
  include UserAuthentication
  include RestrictSubmitterAccess

  prepend_before_action :check_date

  skip_before_action :require_authenticated_user, only: :check_date
  skip_before_action :check_date, only: :closed

  private

  def check_date
    @expiration_date = Date.parse(ENV.fetch('EXPIRATION_DATE'))
    redirect_to helpers.page_route('closed') unless session[:admin] == true || !@expiration_date.past?
  end
end
