# frozen_string_literal: true

class College < ApplicationRecord
  has_and_belongs_to_many :books, dependent: :destroy
  has_and_belongs_to_many :other_publications, dependent: :destroy
  validates :name, presence: true
end
