# frozen_string_literal: true

require 'rails_helper'
require 'publications_helper'

RSpec.describe PublicationsHelper, type: :helper do
  let(:other_publication) { FactoryBot.create(:other_publication) }

  describe '#author_or_artist_label' do
    context 'when the work is an artwork' do
      before do
        allow(helper).to receive(:params).and_return('controller' => 'artworks')
      end

      it 'returns "Artist"' do
        expect(helper.author_or_artist_label).to eq 'Artist'
      end
    end

    context 'when the work is not an artwork' do
      before do
        allow(helper).to receive(:params).and_return('controller' => 'something')
      end

      it 'returns "Author"' do
        expect(helper.author_or_artist_label).to eq 'Author'
      end
    end
  end

  describe '#author_citation' do
    it 'returns the formatted author citation' do
      allow(helper).to receive(:params)
      expect(helper.all_authors(other_publication)).to eq 'First Last, Second None '

      # Call the helper method
      citation = author_citation(other_publication)

      # Define the expected output based on your implementation
      expected_citation = 'Last, First and Second None'

      # Expect the actual output to match the expected output
      expect(citation).to eq(expected_citation)
    end
  end
end
