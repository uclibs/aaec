# frozen_string_literal: true

class DigitalProject < ApplicationRecord
  include CustomValidations
  include Csv

  belongs_to :submitter
  has_and_belongs_to_many :colleges

  serialize :author_first_name, Array
  serialize :author_last_name, Array

  validate :validate_author_first_names_not_empty
  validate :validate_author_last_names_not_empty
  validates :work_title, presence: true

  def self.to_csv
    attributes = %w[submitter_id work_title other_title authors colleges uc_department name_of_site name_of_affiliated_organization publication_date version url doi]
    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |item|
        csv << attributes.map { |attr| item.send(attr) }
      end
    end
  end
end
