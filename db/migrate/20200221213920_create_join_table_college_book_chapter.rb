# frozen_string_literal: true

class CreateJoinTableCollegeBookChapter < ActiveRecord::Migration[5.2]
  def change
    create_join_table :colleges, :book_chapters do |t|
      # t.index [:college_id, :book_chapter_id]
      # t.index [:book_chapter_id, :college_id]
    end
  end
end
