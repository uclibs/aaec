# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MusicalScore, type: :model do
  let(:subject) do
    FactoryBot.build(:musical_score)
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
end
