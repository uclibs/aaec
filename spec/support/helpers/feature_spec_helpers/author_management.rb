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

      # Find the element at the given index
      # (index + 1) is used because nth-child is 1-indexed
      author_to_remove = find("#author_group > :nth-child(#{index + 1})")
      return unless author_to_remove

      # Find the remove button in the author_to_remove element and click it
      remove_button = author_to_remove.find('button', text: 'Remove Author', match: :first)
      remove_button.click
    rescue Capybara::ElementNotFound => e
      raise "Remove Author button could not be found: #{e.message}"
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

    # Assuming authors are direct children of #author_group
    # This method finds the first author element
    def first_author_element
      find('#author_group > :first-child')
    end

    def add_author_or_artist_and_verify_field
      # Dynamically get the current count of fields before adding a new one
      current_count = first_name_fields.size

      author_button_present = has_button?('Add Author', wait: false)
      artist_button_present = has_button?('Add Artist', wait: false)

      raise_errors_for_incorrect_button_states(author_button_present, artist_button_present)

      # Trigger adding a new field based on which button is present
      if author_button_present
        click_on 'Add Author'
        field_selector = "input[name$='[author_first_name][]']"
      elsif artist_button_present
        click_on 'Add Artist'
        field_selector = "input[name$='[author_first_name][]']" # Artist first name field is still "author_first_name"
      end

      # Wait for the next field to appear
      expect(page).to have_selector(field_selector, count: current_count + 1)
    end

    def raise_errors_for_incorrect_button_states(author_button_present, artist_button_present)
      # Fail if both or none of the buttons are present
      if author_button_present && artist_button_present
        raise 'Both "Add Author" and "Add Artist" buttons are present, which is unexpected.'
      elsif !author_button_present && !artist_button_present
        raise 'Neither "Add Author" nor "Add Artist" button is present, cannot proceed.'
      end
    end

    # Returns the collection of author first name fields.
    # @return [Array<Capybara::Node::Element>] The collection of author first name fields.
    def first_name_fields
      expect(page).to have_selector("input[name$='[author_first_name][]']")
      all("input[name$='[author_first_name][]']")
    end

    # Returns the collection of author last name fields.
    # @return [Array<Capybara::Node::Element>] The collection of author last name fields.
    def last_name_fields
      all("input[name$='[author_last_name][]']")
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
  end
end
