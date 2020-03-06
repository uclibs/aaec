# frozen_string_literal: true

class CreateJoinTableCollegePublicPerformance < ActiveRecord::Migration[5.2]
  def change
    create_join_table :colleges, :public_performances do |t|
      # t.index [:college_id, :public_performance_id]
      # t.index [:public_performance_id, :college_id]
    end
  end
end
