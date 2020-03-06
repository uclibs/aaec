# frozen_string_literal: true

class CreateJoinTableCollegeMusicalScore < ActiveRecord::Migration[5.2]
  def change
    create_join_table :colleges, :musical_scores do |t|
      # t.index [:college_id, :musical_score_id]
      # t.index [:musical_score_id, :college_id]
    end
  end
end
