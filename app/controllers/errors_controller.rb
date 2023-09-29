# frozen_string_literal: true

# app/controllers/errors_controller.rb
class ErrorsController < ApplicationController
  # Per Infosec, all errors should route to the 404 page, not the 422 or 500 pages.
  def not_found
    render template: 'errors/404', layout: 'application', status: :not_found
  end
end
