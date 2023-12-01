# frozen_string_literal: true

# app/controllers/pages_controller.rb
class PagesController < ApplicationController
  skip_before_action :check_date
  ALLOWED_PAGES = %w[closed finished].freeze

  def show
    if valid_page?
      puts "INFO: Rendering #{safe_page}"
      render template: "pages/#{safe_page}"
    else
      render template: 'errors/404', status: :not_found
    end
  end

  private

  def valid_page?
    params[:page].is_a?(String) && ALLOWED_PAGES.include?(params[:page])
  end

  def safe_page
    ALLOWED_PAGES.find { |page| page == params[:page].to_s }
  end
end
