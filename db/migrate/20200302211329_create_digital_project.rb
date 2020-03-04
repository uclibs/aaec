# frozen_string_literal: true

class CreateDigitalProject < ActiveRecord::Migration[5.2]
  def change
    create_table :digital_projects do |t|
      t.string :author_first_name
      t.string :author_last_name
      t.string :college_ids
      t.string :other_college
      t.string :uc_department
      t.string :work_title
      t.string :other_title
      t.string :name_of_site
      t.string :name_of_affiliated_organization
      t.string :publication_date
      t.string :version
      t.string :url
      t.string :doi
      t.string :submitter_id
    end
  end
end
