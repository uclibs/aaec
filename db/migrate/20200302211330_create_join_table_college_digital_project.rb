# frozen_string_literal: true

class CreateJoinTableCollegeDigitalProject < ActiveRecord::Migration[5.2]
  def change
    create_join_table :colleges, :digital_projects do |t|
      # t.index [:college_id, :digital_project_id]
      # t.index [:digital_project_id, :college_id]
    end
  end
end
