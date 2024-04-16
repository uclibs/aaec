# frozen_string_literal: true

class Play < ApplicationRecord
  include Csv
  has_and_belongs_to_many :colleges
  validates :work_title, presence: true
  validate :validate_author_names
  serialize :author_first_name, Array
  serialize :author_last_name, Array

  def self.to_csv
    attributes = %w[submitter_id work_title other_title authors colleges uc_department publisher city publication_date url doi]
    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |item|
        csv << attributes.map { |attr| item.send(attr) }
      end
    end
  end
end
