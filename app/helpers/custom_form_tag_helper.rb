# frozen_string_literal: true

# This module is used to set autocomplete='off' on all select_tag fields.
# Setting this attribute to off prevents the browser from remembering
# previously entered values.
# See https://developer.mozilla.org/en-US/docs/Web/Security/Securing_your_site/Turning_off_form_autocompletion
# for more information.
#
module CustomFormTagHelper
  def select_tag(name, option_tags = nil, options = {})
    options[:autocomplete] = 'off' unless options.key?(:autocomplete)
    super
  end
end
