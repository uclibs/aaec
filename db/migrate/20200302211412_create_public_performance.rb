# frozen_string_literal: true

class CreatePublicPerformance < ActiveRecord::Migration[5.2]
  def change
    create_table :public_performances do |t|
      t.string :author_first_name
      t.string :author_last_name
      t.string :college_ids
      t.string :other_college
      t.string :uc_department
      t.string :work_title
      t.string :other_title
      t.string :location
      t.string :time
      t.string :date
      t.string :submitter_id
    end
  end
end
