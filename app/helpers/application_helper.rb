# frozen_string_literal: false

module ApplicationHelper
  include Pagy::Frontend


  def shorten_long(input)
    input_array = input.strip.split(/\s+/)
    return_string = ''
    input_array.each do |item|
      return_string << ("#{Truncato.truncate item, max_length: 16} ")
    end
    return_string
  end

  def csv_route(type)
    ENV['RAILS_RELATIVE_URL_ROOT'].to_s + "/csv/#{type}.csv"
  end

  def page_route(page)
    ENV['RAILS_RELATIVE_URL_ROOT'].to_s + "/pages/#{page}"
  end
end
