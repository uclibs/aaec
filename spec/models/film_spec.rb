# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Film, type: :model do
  let(:subject) do
    FactoryBot.build(:film)
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
    FactoryBot.create(:film)
    csv = Film.to_csv
    expect(csv).to include('submitter_id')
    expect(csv).to include('work_title')
    expect(csv).to include('other_title')
    expect(csv).to include('authors')
    expect(csv).to include('colleges')
    expect(csv).to include('uc_department')
    expect(csv).to include('producer')
    expect(csv).to include('director')
    expect(csv).to include('release_year')

    expect(csv).to include(subject.work_title)
  end
end
