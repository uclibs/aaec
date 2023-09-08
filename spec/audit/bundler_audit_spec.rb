# frozen_string_literal: true

# spec/audit/bundler_audit_spec.rb
require 'rails_helper'
require 'spec_helper'
require 'open3'

RSpec.describe 'Bundler Audit' do
  it 'does not find vulnerabilities' do
    Open3.popen3('bundle audit check --update') do |_stdin, stdout, stderr, thread|
      expect(thread.value).to be_success, "Vulnerabilities found:\n#{stdout.read}#{stderr.read}"
    end
  end
end
