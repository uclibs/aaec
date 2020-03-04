# frozen_string_literal: true

module PhotographiesHelper
  def find_photographies(id)
    Array.wrap(Photography.where(submitter_id: id))
  end
end
