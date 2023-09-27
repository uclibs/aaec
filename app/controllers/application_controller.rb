# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend

  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActiveRecord::RecordInvalid, with: :render_422
  rescue_from StandardError, with: :render_500
  

  before_action :check_date

  def render_404(exception)
    render template: 'errors/404', layout: 'application', status: :not_found
  end

  def render_422(exception)
    render template: 'errors/422', layout: 'application', status: :unprocessable_entity
  end

  def render_500(exception)
    logger.error exception
    render template: 'errors/500', layout: 'application', status: :internal_server_error
  end

  private

  def check_date
    @expiration_date = Date.parse(ENV.fetch('EXPIRATION_DATE'))
    redirect_to helpers.page_route('closed') unless session[:admin] == true || !@expiration_date.past?
  end
end
