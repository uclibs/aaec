# frozen_string_literal: true

class Submitter < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :mailing_address, presence: true
  validates :phone_number, presence: true, format: { with: /\d{3}-\d{3}-\d{4}/, message: 'Please use the format 111-111-1111' }
  validates :email_address, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: 'Please enter a valid email' }
end
