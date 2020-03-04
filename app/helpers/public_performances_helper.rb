# frozen_string_literal: true

module PublicPerformancesHelper
  def find_public_performances(id)
    Array.wrap(PublicPerformance.where(submitter_id: id))
  end
end
