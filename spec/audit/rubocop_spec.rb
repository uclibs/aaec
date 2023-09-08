# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
require 'open3'

RSpec.describe 'RuboCop Check' do
  it 'does not find any violations' do
    Open3.popen3('rubocop') do |_stdin, stdout, stderr, thread|
      output = stdout.read + stderr.read
      expect(thread.value).to be_success, "RuboCop violations were found:\n#{output}"
    end
  end
end
