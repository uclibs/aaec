# frozen_string_literal: true

class ChangeCollegeToBeInteger < ActiveRecord::Migration[5.2]
  def change
    change_column :submitters, :college, :integer
  end
end
