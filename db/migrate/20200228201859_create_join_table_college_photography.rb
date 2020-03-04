# frozen_string_literal: true

class CreateJoinTableCollegePhotography < ActiveRecord::Migration[5.2]
  def change
    create_join_table :colleges, :photographies do |t|
      # t.index [:college_id, :photography_id]
      # t.index [:photography_id, :college_id]
    end
  end
end
