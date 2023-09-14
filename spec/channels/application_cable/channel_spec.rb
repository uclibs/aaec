# frozen_string_literal: true

# spec/channels/application_cable/channel_spec.rb

require 'rails_helper'

RSpec.describe ApplicationCable::Channel, type: :channel do
  it 'inherits from ActionCable::Channel::Base' do
    expect(described_class).to be < ActionCable::Channel::Base
  end
end
