# frozen_string_literal: false

module SubmittersHelper
  def find_submitter(id)
    Submitter.find_by(id:)
  end

  def find_submitters(id)
    Array.wrap(Submitter.find(id))
  end

  def submitter_name(submitter)
    "#{submitter.first_name} #{submitter.last_name}"
  end

  def filter_name(name)
    name_array = name.strip.split(/\s+/)
    return_string = ''
    name_array.each do |item|
      return_string << ("#{Truncato.truncate item, max_length: 16} ")
    end
    return_string
  end
end
