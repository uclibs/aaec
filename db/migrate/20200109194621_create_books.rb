# frozen_string_literal: true

class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :author_first_name
      t.string :author_last_name
      t.string :college_ids
      t.string :uc_department
      t.string :work_title
      t.string :other_title
      t.string :publisher
      t.string :city
      t.string :publication_date
      t.string :url
      t.string :doi
      t.string :submitter_id

      t.timestamps
    end
  end
end
