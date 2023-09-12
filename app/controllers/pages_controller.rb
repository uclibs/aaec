# frozen_string_literal: true

# app/controllers/pages_controller.rb
class PagesController < ApplicationController
  ALLOWED_PAGES = %w[closed finished].freeze

  skip_before_action :check_date
  VALID_PAGES = %w[closed finished].freeze # Add or remove pages as needed

  def show
    if valid_page?
      render template: "pages/#{ALLOWED_PAGES.find { |page| page == params[:page].to_s }}"
    else
      render file: 'public/404.html', status: :not_found
    end
  end

  private

  def valid_page?
    params[:page].is_a?(String) && ALLOWED_PAGES.include?(params[:page])
  end
end
