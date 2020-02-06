# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def signed_in
    session[:admin] || session[:submitter_id]
  end
end
