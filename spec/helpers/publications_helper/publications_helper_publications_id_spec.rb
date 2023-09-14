# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PublicationsHelper, type: :helper do
  let(:other_publication) { FactoryBot.create(:other_publication) }

  describe '#publications_id' do
    context 'when given a valid id' do
      let(:id) { 1 }

      it 'returns the correct path' do
        expect(helper.publications_id(id)).to eq("/publications/#{id}")
      end
    end

    context 'when given an id as a string' do
      let(:id) { '1' }

      it 'returns the correct path' do
        expect(helper.publications_id(id)).to eq("/publications/#{id}")
      end
    end

    context 'when given a nil id' do
      it 'returns the correct path' do
        expect(helper.publications_id(nil)).to eq('/publications/')
      end
    end
  end
end
