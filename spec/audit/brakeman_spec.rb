# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
require 'open3'

RSpec.describe 'Brakeman Check' do
  it 'does not find vulnerabilities' do
    Open3.popen3('brakeman -q -w 2') do |_stdin, stdout, stderr, thread|
      expect(thread.value).to be_success, "Vulnerabilities found:\n#{stdout.read}#{stderr.read}"
    end
  end
end
