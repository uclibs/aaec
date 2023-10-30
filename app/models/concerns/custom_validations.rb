# frozen_string_literal: true

# CustomValidations is a Rails concern that enhances ActiveRecord models with
# additional validation methods. These methods address edge cases not handled
# by built-in ActiveRecord validations.
#
# This module extends ActiveSupport::Concern, making it straightforward
# to include in any ActiveRecord model.
#
# One key use-case for CustomValidations is to more rigorously validate presence.
# For instance, an array like [''] would pass the standard `validates_presence_of`
# check, but may not be considered valid according to business rules.
#
# @example Usage in an ActiveRecord model
#   class OtherPublication < ApplicationRecord
#     include CustomValidations
#     validate :validate_author_first_names_not_empty
#   end
module CustomValidations
  extend ActiveSupport::Concern

  def validate_author_first_names_not_empty
    return unless author_first_name.blank? || author_first_name.all?(&:blank?)

    errors.add(:author_first_name, "can't be empty")
  end

  def validate_author_last_names_not_empty
    return unless author_last_name.blank? || author_last_name.all?(&:blank?)

    errors.add(:author_last_name, "can't be empty")
  end
end
