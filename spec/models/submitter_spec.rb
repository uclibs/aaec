# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Submitter, type: :model do
  let(:subject) do
    FactoryBot.build(:submitter)
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a first_name' do
    subject.first_name = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a last_name' do
    subject.last_name = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a mailing_address' do
    subject.mailing_address = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a phone_number' do
    subject.phone_number = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a email_address' do
    subject.email_address = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a formatted phone_number' do
    subject.phone_number = '1111111111'
    expect(subject).to_not be_valid
  end

  it 'is not valid without a formatted email_address' do
    subject.email_address = 'testfake.com'
    expect(subject).to_not be_valid
  end
end
