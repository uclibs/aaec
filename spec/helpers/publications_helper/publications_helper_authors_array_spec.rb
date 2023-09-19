# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PublicationsHelper, type: :helper do
  let(:other_publication) { FactoryBot.create(:other_publication) }

  describe '#authors_array' do
    context 'when no authors are present' do
      let(:publication) { double(author_first_name: [], author_last_name: []) }

      it 'returns an array with an empty string' do
        expect(helper.authors_array(publication)).to eq([' '])
      end
    end

    context 'when there is one author' do
      let(:publication) { double(author_first_name: ['John'], author_last_name: ['Doe']) }

      it 'returns an array with a single truncated author' do
        expect(helper.authors_array(publication)).to eq(['John Doe'])
      end
    end

    context 'when there are multiple authors' do
      let(:publication) { double(author_first_name: %w[John Jane], author_last_name: %w[Doe Roe]) }

      it 'returns an array of truncated authors' do
        expect(helper.authors_array(publication)).to eq(['John Doe', 'Jane Roe'])
      end
    end

    context 'when publication is nil' do
      it 'returns an empty array' do
        expect(helper.authors_array(nil)).to eq([])
      end
    end

    context 'when author attributes are nil' do
      let(:publication) { double(author_first_name: nil, author_last_name: nil) }

      it 'returns an empty array' do
        expect(helper.authors_array(publication)).to eq([])
      end
    end

    context 'when author names are very long' do
      let(:long_name) { 'A' * 100 } # 100 characters
      let(:publication) { double(author_first_name: [long_name], author_last_name: [long_name]) }

      before do
        allow(Truncato).to receive(:truncate).and_call_original
      end

      it 'truncates the author name to 12 characters plus 3 elipses' do
        truncated_name = helper.authors_array(publication).first
        expect(truncated_name.length).to eq(15)
        expect(Truncato).to have_received(:truncate).with("#{long_name} #{long_name}", max_length: 12)
        expect(truncated_name[-3..]).to eq('...') # ends with elipses
      end
    end
  end
end
