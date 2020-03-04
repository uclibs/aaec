# frozen_string_literal: true

module MusicalScoresHelper
  def find_musical_scores(id)
    Array.wrap(MusicalScore.where(submitter_id: id))
  end
end
