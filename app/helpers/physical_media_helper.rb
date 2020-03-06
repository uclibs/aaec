# frozen_string_literal: true

module PhysicalMediaHelper
  def find_physical_media(id)
    Array.wrap(PhysicalMedium.where(submitter_id: id))
  end
end
