# frozen_string_literal: true

# CustomValidations is a Rails concern that enhances ActiveRecord models with
# additional validation methods. These methods address edge cases not handled
# by built-in ActiveRecord validations.
#
# This module extends ActiveSupport::Concern, making it straightforward
# to include in any ActiveRecord model. It is included in the parent class
# ApplicationRecord, so all models that inherit from ApplicationRecord
# will have access to these methods.
#
# One key use-case for CustomValidations is to more rigorously validate presence.
# For instance, an array like [''] would pass the standard `validates_presence_of`
# check, but may not be considered valid according to business rules.
#
# @example Usage in an ActiveRecord model
#   class OtherPublication < ApplicationRecord
#
#     validate :validate_author_names

#   end
module AuthorNameValidations
  extend ActiveSupport::Concern

  def validate_author_names
    validate_name_not_empty(:author_first_name)
    validate_name_not_empty(:author_last_name)
    validate_names_length
  end

  private

  def validate_name_not_empty(attribute)
    return if send(attribute).present? && send(attribute).none?(&:blank?)

    errors.add(attribute, "can't be empty or contain blank entries")
  end

  def validate_names_length
    return if author_first_name&.length == author_last_name&.length

    errors.add(:base, 'Both first and last names are required and must have the same number of entries')
  end
end
