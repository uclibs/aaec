# frozen_string_literal: true

class CreateJoinTableCollegeFilm < ActiveRecord::Migration[5.2]
  def change
    create_join_table :colleges, :films do |t|
      # t.index [:college_id, :film_id]
      # t.index [:film_id, :college_id]
    end
  end
end
