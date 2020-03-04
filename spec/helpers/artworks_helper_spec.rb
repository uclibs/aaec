# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArtworksHelper, type: :helper do
  let(:artwork) { FactoryBot.create(:artwork) }

  describe '#find_artworks(id)' do
    it 'returns the requested artworks in an array' do
      expect(helper.find_artworks(artwork.submitter_id)).to eq Array.wrap(artwork)
    end
  end
end
