# frozen_string_literal: true

class College < ApplicationRecord
  has_and_belongs_to_many :books, dependent: :destroy
  has_and_belongs_to_many :other_publications, dependent: :destroy
  validates :name, presence: true

  def self.name_for(id)
    return '' if id.nil?

    college = College.find_by(id:)
    college&.name.to_s
  end
end
