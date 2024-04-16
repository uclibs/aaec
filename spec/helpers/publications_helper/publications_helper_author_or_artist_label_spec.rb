# frozen_string_literal: true

require 'rails_helper'

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
end
