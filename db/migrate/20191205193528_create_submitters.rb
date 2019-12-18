# frozen_string_literal: true

class CreateSubmitters < ActiveRecord::Migration[5.2]
  def change
    create_table :submitters do |t|
      t.string :first_name
      t.string :last_name
      t.string :college
      t.string :department
      t.string :mailing_address
      t.string :phone_number
      t.string :email_address

      t.timestamps
    end
  end
end
