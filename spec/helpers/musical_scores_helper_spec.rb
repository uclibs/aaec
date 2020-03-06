# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MusicalScoresHelper, type: :helper do
  let(:musical_score) { FactoryBot.create(:musical_score) }

  describe '#find_musical_scores(id)' do
    it 'returns the requested book chapters in an array' do
      expect(helper.find_musical_scores(musical_score.submitter_id)).to eq Array.wrap(musical_score)
    end
  end
end
