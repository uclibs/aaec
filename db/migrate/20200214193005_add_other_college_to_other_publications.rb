# frozen_string_literal: true

class AddOtherCollegeToOtherPublications < ActiveRecord::Migration[5.2]
  def change
    add_column :other_publications, :other_college, :string
  end
end
