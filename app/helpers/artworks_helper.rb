# frozen_string_literal: true

module ArtworksHelper
  def find_artworks(id)
    Array.wrap(Artwork.where(submitter_id: id))
  end
end
