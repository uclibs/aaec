# frozen_string_literal: true

class CreateJoinTableCollegePlay < ActiveRecord::Migration[5.2]
  def change
    create_join_table :colleges, :plays do |t|
      # t.index [:college_id, :play_id]
      # t.index [:play_id, :college_id]
    end
  end
end
