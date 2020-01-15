# frozen_string_literal: true

class Book < ApplicationRecord
  has_and_belongs_to_many :colleges
  validates :author_first_name, presence: true
  validates :author_last_name, presence: true
  validates :work_title, presence: true
end
