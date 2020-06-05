# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PublicPerformance, type: :model do
  let(:subject) do
    FactoryBot.build(:public_performance)
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a author_first_name' do
    subject.author_first_name = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a author_last_name' do
    subject.author_last_name = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a work_title' do
    subject.work_title = nil
    expect(subject).to_not be_valid
  end

  it 'generates a valid csv' do
    FactoryBot.create(:public_performance)
    csv = PublicPerformance.to_csv
    expect(csv).to include('submitter_id')
    expect(csv).to include('work_title')
    expect(csv).to include('other_title')
    expect(csv).to include('authors')
    expect(csv).to include('colleges')
    expect(csv).to include('uc_department')
    expect(csv).to include('location')
    expect(csv).to include('time')
    expect(csv).to include('date')

    expect(csv).to include(subject.work_title)
  end
end
