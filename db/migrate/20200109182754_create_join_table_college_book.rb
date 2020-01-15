# frozen_string_literal: true

class CreateJoinTableCollegeBook < ActiveRecord::Migration[5.2]
  def change
    create_join_table :colleges, :books do |t|
      # t.index [:college_id, :book_id]
      # t.index [:book_id, :college_id]
    end
  end
end
