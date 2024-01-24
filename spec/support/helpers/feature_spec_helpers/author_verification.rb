# frozen_string_literal: true

module FeatureSpecHelpers
  # AuthorManagement provides helper methods for managing author fields in feature tests.
  # It includes functionality to add, remove, and verify authors in a publication context,
  # specifically catering to dynamic web page interactions with Capybara.
  # Methods within this module handle tasks like removing authors at a specific index,
  # checking field values, and finding parent elements in the DOM structure.
  module AuthorManagement
    def remove_author_at_index(index)
      return if index.zero? # The first author cannot be removed
      return unless valid_index?(index)

      parent_element = find_parent_element(first_name_fields[index])
      return unless parent_element

      remove_author_from(parent_element)
    end

    def check_field_values_by_index(index, expected_first_name, expected_last_name)
      return unless valid_index?(index)

      verify_field_value(
        fields: first_name_fields,
        index:,
        expected_value: expected_first_name,
        field_name: 'First name'
      )

      verify_field_value(
        fields: last_name_fields,
        index:,
        expected_value: expected_last_name,
        field_name: 'Last name'
      )
    end

    private

    # Returns the collection of author first name fields.
    # @return [Array<Capybara::Node::Element>] The collection of author first name fields.
    def first_name_fields
      all("input[name$='[author_first_name][]']", wait: Capybara.default_max_wait_time)
    end

    # Returns the collection of author last name fields.
    # @return [Array<Capybara::Node::Element>] The collection of author last name fields.
    def last_name_fields
      all("input[name$='[author_last_name][]']", wait: Capybara.default_max_wait_time)
    end

    # Finds the parent element of a given field.
    # @param [Capybara::Node::Element] field - The Capybara element for which parent is to be found.
    # @return [Capybara::Node::Element] The parent element of the provided field.
    def find_parent_element(field)
      field.find(:xpath, '../..')
    rescue Capybara::ElementNotFound => e
      raise "Parent element could not be found: #{e.message}"
    end

    # Validates if the provided index is within the range of existing author fields.
    # @param [Integer] index - The index to validate.
    # @return [Boolean] True if the index is valid, false otherwise.
    def valid_index?(index)
      index.between?(0, [first_name_fields.size, last_name_fields.size].min - 1)
    end

    # Verifies the value of a field against the expected value.
    # @param fields: [Array<Capybara::Node::Element>] The collection of fields to verify.
    # @param index: [Integer] The index of the field to check.
    # @param expected_value: [String] The expected value of the field.
    # @param field_name: [String] The name of the field (for error messages).
    def verify_field_value(fields:, index:, expected_value:, field_name:)
      field = fields[index]
      actual_value = field.value
      error_message = "#{field_name} at index #{index} does not match"
      expect(actual_value).to eq(expected_value), error_message
    end

    # Clicks the 'Remove Author' button within the specified parent element.
    # @param [Capybara::Node::Element] parent_element - The parent element containing the remove button.
    def remove_author_from(parent_element)
      remove_button = parent_element.find('button', text: 'Remove Author', match: :first)
      remove_button.click
    rescue Capybara::ElementNotFound => e
      raise "Remove Author button could not be found: #{e.message}"
    end
  end
end
