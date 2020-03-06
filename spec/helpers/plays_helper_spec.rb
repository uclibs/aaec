# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PlaysHelper, type: :helper do
  let(:play) { FactoryBot.create(:play) }

  describe '#find_plays(id)' do
    it 'returns the requested book chapters in an array' do
      expect(helper.find_plays(play.submitter_id)).to eq Array.wrap(play)
    end
  end
end
