# frozen_string_literal: true

# This class is used to set autocomplete='off' on all form fields.
# Setting this attribute to off prevents the browser from remembering
# previously entered values.
# See https://developer.mozilla.org/en-US/docs/Web/Security/Securing_your_site/Turning_off_form_autocompletion
# for more information.
#
class AutocompleteOffFormBuilder < ActionView::Helpers::FormBuilder
  FORM_FIELD_METHODS = %i[
    text_field
    password_field
    email_field
    number_field
    text_area
    search_field
    telephone_field
    url_field
    file_field
  ].freeze

  FORM_FIELD_METHODS.each do |method_name|
    define_method(method_name) do |attribute, options = {}|
      options[:autocomplete] ||= 'off'
      super(attribute, options)
    end
  end

  def select(attribute, choices = nil, options = {}, html_options = {}, &)
    html_options[:autocomplete] ||= 'off'
    super(attribute, choices, options, html_options, &)
  end
end
