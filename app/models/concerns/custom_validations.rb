# frozen_string_literal: true

# CustomValidations module provides custom validation methods for ActiveRecord models.
# It's designed to extend ActiveSupport::Concern, making it easier to include these
# validations into any ActiveRecord model.
#
# The reason this concern was created is to handle cases where the built-in
# `validates_presence_of` was not sufficient. For example, an author_first_name of ['']
# would pass the `validates_presence_of` check, which is not the desired behavior.
#
# @example Including CustomValidations in a model
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
