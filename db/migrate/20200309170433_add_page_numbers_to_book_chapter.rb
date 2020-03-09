# frozen_string_literal: true

class AddPageNumbersToBookChapter < ActiveRecord::Migration[5.2]
  def change
    add_column :book_chapters, :page_numbers, :string
  end
end
