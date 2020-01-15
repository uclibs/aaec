# frozen_string_literal: true

class CreateJoinTableCollegeOtherPublication < ActiveRecord::Migration[5.2]
  def change
    create_join_table :colleges, :other_publications do |t|
      # t.index [:college_id, :publication_id]
      # t.index [:publication_id, :college_id]
    end
  end
end
