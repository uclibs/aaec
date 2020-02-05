# frozen_string_literal: true

module SubmittersHelper
  def find_submitter(id)
    Submitter.find(id)
  end

  def find_submitters(id)
    Array.wrap(Submitter.find(id))
  end
end
