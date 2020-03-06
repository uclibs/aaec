# frozen_string_literal: true

class CreateJoinTableCollegeEditing < ActiveRecord::Migration[5.2]
  def change
    create_join_table :colleges, :editings do |t|
      # t.index [:college_id, :editing_id]
      # t.index [:editing_id, :college_id]
    end
  end
end
