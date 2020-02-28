# frozen_string_literal: true

class AddOtherCollegeToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :other_college, :string
  end
end
