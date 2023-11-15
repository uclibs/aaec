# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PublicationsHelper, type: :helper do
  let(:other_publication) { FactoryBot.create(:other_publication) }

  describe '#author_citation' do
    context 'when no authors are present' do
      let(:publication) { double(author_first_name: [], author_last_name: []) }

      it 'returns two empty strings separated by a comma' do
        expect(helper.author_citation(publication)).to eq(', ')
      end
    end

    context 'when there is one author' do
      let(:publication) { double(author_first_name: ['John'], author_last_name: ['Doe']) }

      it 'returns a single author in citation format' do
        expect(helper.author_citation(publication)).to eq('Doe, John')
      end
    end

    context 'when there are two authors' do
      let(:publication) { double(author_first_name: %w[John Jane], author_last_name: %w[Doe Roe]) }

      it 'returns all authors in citation format' do
        expect(helper.author_citation(publication)).to eq('Doe, John and Jane Roe')
      end
    end

    context 'when there are more than two authors' do
      let(:publication) { double(author_first_name: %w[John Jane Mary Jo], author_last_name: %w[Doe Roe Wallace Smith]) }

      it 'returns all authors in citation format' do
        expect(helper.author_citation(publication)).to eq('Doe, John, Roe, Jane, Wallace, Mary and Jo Smith')
      end
    end

    context 'when publication is nil' do
      it 'returns an empty string' do
        expect(helper.author_citation(nil)).to eq('')
      end
    end

    context 'when author attributes are nil' do
      let(:publication) { double(author_first_name: nil, author_last_name: nil) }

      it 'returns an empty string' do
        expect(helper.author_citation(publication)).to eq('')
      end
    end
  end
end
