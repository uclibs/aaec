# frozen_string_literal: false

module ApplicationHelper
  include Pagy::Frontend

  def signed_in
    session[:admin] || session[:submitter_id]
  end

  def shorten_long(input)
    input_array = input.strip.split(/\s+/)
    return_string = ''
    input_array.each do |item|
      return_string << ((Truncato.truncate item, max_length: 16) + ' ')
    end
    return_string
  end
end
