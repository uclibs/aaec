# frozen_string_literal: true

class OtherPublication < ApplicationRecord
  include Csv
  serialize :author_first_name, Array
  serialize :author_last_name, Array
  has_and_belongs_to_many :colleges
  validates :author_first_name, presence: true
  validates :author_last_name, presence: true
  validates :work_title, presence: true

  def self.to_csv
    attributes = %w[submitter_id work_title other_title authors colleges uc_department volume issue page_numbers publisher city publication_date url doi]
    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |item|
        csv << attributes.map { |attr| item.send(attr) }
      end
    end
  end
end
