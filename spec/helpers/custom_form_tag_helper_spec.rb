# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CustomFormTagHelper, type: :helper do
  include CustomFormTagHelper

  describe '#select_tag' do
    it 'adds autocomplete="off" by default' do
      html = select_tag('test_select', '<option>Option</option>')
      expect(html).to include('autocomplete="off"')
    end

    it 'does not override explicitly set autocomplete' do
      html = select_tag('test_select', '<option>Option</option>', autocomplete: 'on')
      expect(html).to include('autocomplete="on"')
    end
  end
end
