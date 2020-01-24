# frozen_string_literal: true

module OtherPublicationsHelper
  def find_other_publications(id)
    Array.wrap(OtherPublication.where(submitter_id: id))
  end
end
