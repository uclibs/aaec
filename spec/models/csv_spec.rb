# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Csv do
  let(:model) do
    FactoryBot.build(:other_publication)
  end

  let(:submitter) do
    FactoryBot.build(:submitter)
  end

  it 'valid college_name id' do
    expect(model.college_name(1)).to eq('Allied Health Sciences')
  end

  it 'invalid college_name id' do
    expect(model.college_name(nil)).to eq('')
  end

  it 'returns college' do
    submitter.college = 1
    expect(submitter.submitter_college).to eq('Allied Health Sciences')
  end

  it 'adds department if college is other' do
    submitter.college = 16
    submitter.department = 'Test Department'
    expect(submitter.submitter_college).to eq('Other: Test Department')
  end
end
