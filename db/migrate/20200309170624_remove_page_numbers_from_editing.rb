# frozen_string_literal: true

class RemovePageNumbersFromEditing < ActiveRecord::Migration[5.2]
  def change
    remove_column :editings, :page_numbers, :string
  end
end
