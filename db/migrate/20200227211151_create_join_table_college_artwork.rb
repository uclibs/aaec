# frozen_string_literal: true

class CreateJoinTableCollegeArtwork < ActiveRecord::Migration[5.2]
  def change
    create_join_table :colleges, :artworks do |t|
      # t.index [:college_id, :artwork_id]
      # t.index [:artwork_id, :college_id]
    end
  end
end
