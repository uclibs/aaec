# frozen_string_literal: true

module FilmsHelper
  def find_films(id)
    Array.wrap(Film.where(submitter_id: id))
  end
end
