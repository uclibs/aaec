# frozen_string_literal: true

class CreateFilm < ActiveRecord::Migration[5.2]
  def change
    create_table :films do |t|
      t.string :author_first_name
      t.string :author_last_name
      t.string :college_ids
      t.string :other_college
      t.string :uc_department
      t.string :work_title
      t.string :other_title
      t.string :director
      t.string :release_year
      t.string :submitter_id
    end
  end
end
