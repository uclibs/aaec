# frozen_string_literal: true

class PagesController < ApplicationController
  skip_before_action :check_date
  VALID_PAGES = %w[closed finished].freeze # Add or remove pages as needed

  def show
    if valid_page?
      render template: "pages/#{params[:page]}"
    else
      render file: 'public/404.html', status: :not_found
    end
  end

  private

  def valid_page?
    VALID_PAGES.include?(params[:page])
  end
end
