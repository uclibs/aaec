# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AutocompleteOffFormBuilder, type: :helper do
  let(:object) { double('object', some_attribute: 'value') }
  let(:object_name) { 'thing' }

  subject(:builder) { described_class.new(object_name, object, helper, {}) }

  AutocompleteOffFormBuilder::FORM_FIELD_METHODS.each do |method_name|
    it "adds autocomplete='off' to #{method_name}" do
      field_html = builder.send(method_name, :some_attribute)
      expect(field_html).to include('autocomplete="off"')
    end
  end

  it "adds autocomplete='off' to select method" do
    select_html = builder.select(:some_attribute, [['Option 1', 1], ['Option 2', 2]])
    expect(select_html).to include('autocomplete="off"')
  end

  it 'does not override explicitly set autocomplete attribute but still is present where not overridden' do
    custom_autocomplete_value = 'on'
    text_field_html = builder.text_field(:some_attribute, autocomplete: custom_autocomplete_value)
    select_html = builder.select(:some_attribute, [['Option 1', 1], ['Option 2', 2]])
    expect(select_html).to include('autocomplete="off"')
    expect(text_field_html).to include('autocomplete="on"')
  end
end
