# frozen_string_literal: true

class Submitter < ApplicationRecord
  include Csv
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :mailing_address, presence: true
  validates :phone_number, presence: true, format: { with: /\A\d{3}-\d{3}-\d{4}\z/, message: 'Please use the format 111-111-1111' }
  validates :email_address, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: 'Please enter a valid email' }

  def self.to_csv
    attributes = %w[first_name last_name submitter_college department mailing_address phone_number email_address]
    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |item|
        csv << attributes.map { |attr| item.send(attr) }
      end
    end
  end
end
