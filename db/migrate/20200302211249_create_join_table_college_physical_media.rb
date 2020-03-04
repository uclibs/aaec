# frozen_string_literal: true

class CreateJoinTableCollegePhysicalMedia < ActiveRecord::Migration[5.2]
  def change
    create_join_table :colleges, :physical_media do |t|
      # t.index [:college_id, :physical_media_id]
      # t.index [:physical_media_id, :college_id]
    end
  end
end
