# frozen_string_literal: true

class CreateBookChapters < ActiveRecord::Migration[5.2]
  def change
    create_table :book_chapters do |t|
      t.string :author_first_name
      t.string :author_last_name
      t.string :college_ids
      t.string :other_college
      t.string :uc_department
      t.string :work_title
      t.string :other_title
      t.string :publisher
      t.string :city
      t.string :publication_date
      t.string :url
      t.string :doi
      t.string :submitter_id
    end
  end
end
