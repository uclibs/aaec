# frozen_string_literal: true
# app/controllers/errors_controller.rb
class ErrorsController < ApplicationController
  def not_found
    render template: 'errors/404', layout: 'application', status: :not_found
  end

  def unprocessable_entity
    render template: 'errors/422', layout: 'application', status: :unprocessable_entity
  end

  def internal_server_error
    render template: 'errors/500', layout: 'application', status: :internal_server_error
  end
end