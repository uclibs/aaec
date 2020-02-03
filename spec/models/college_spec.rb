# frozen_string_literal: true

require 'rails_helper'

RSpec.describe College, type: :model do
  let(:subject) do
    FactoryBot.build(:college)
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end
end
