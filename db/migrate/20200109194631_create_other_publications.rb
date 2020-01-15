# frozen_string_literal: true

class CreateOtherPublications < ActiveRecord::Migration[5.2]
  def change
    create_table :other_publications do |t|
      t.string :author_first_name
      t.string :author_last_name
      t.string :college_ids
      t.string :uc_department
      t.string :work_title
      t.string :other_title
      t.string :volume
      t.string :issue
      t.string :page_numbers
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
