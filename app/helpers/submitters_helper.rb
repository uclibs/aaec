# frozen_string_literal: true

module SubmittersHelper
  def find_submitter(id)
    Array.wrap(Submitter.find(id))
  end
end
