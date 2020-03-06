# frozen_string_literal: true

module PlaysHelper
  def find_plays(id)
    Array.wrap(Play.where(submitter_id: id))
  end
end
