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

  it 'is valid with a properly formatted phone_number' do
    subject.phone_number = '111-111-1111'
    expect(subject).to be_valid
  end

  it 'is not valid without a phone_number' do
    subject.phone_number = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid with an improperly formatted phone_number' do
    [
      '1111111111',       # no dashes
      '111-1111-1111',    # too many digits
      '11-111-1111',      # too few digits
      '111-111-1111abc',  # additional characters
      'abc111-111-1111',  # additional characters
      '1-111-111-1111'    # too many sections and digits
    ].each do |invalid_number|
      subject.phone_number = invalid_number
      expect(subject).to_not be_valid, "Expected #{invalid_number} to be invalid"
    end
  end

  it 'is not valid without a email_address' do
    subject.email_address = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a formatted email_address' do
    subject.email_address = 'testfake.com'
    expect(subject).to_not be_valid
  end

  it 'generates a valid csv' do
    submitter = FactoryBot.create(:submitter)
    csv = Submitter.to_csv
    expect(csv).to include('first_name')
    expect(csv).to include('last_name')
    expect(csv).to include('college')
    expect(csv).to include('department')
    expect(csv).to include('mailing_address')
    expect(csv).to include('phone_number')
    expect(csv).to include('email_address')

    expect(csv).to include(submitter.first_name)
  end
end
