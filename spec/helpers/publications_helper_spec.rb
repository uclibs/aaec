# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PublicationsHelper, type: :helper do
  let(:other_publication) { FactoryBot.create(:other_publication) }

  describe '#all_authors(publication)' do
    it 'returns all authors for a work in a string' do
      expect(helper.all_authors(other_publication)).to eq 'First Last, Second None '
    end
  end

  describe '#author_name(publication, position)' do
    it 'returns the author for a specific position in a string' do
      expect(helper.author_name(other_publication, 1)).to eq 'Second None'
    end
  end

  describe '#author_comma(publication, position)' do
    it 'returns the author comma separated for a specific position in a string' do
      expect(helper.author_comma(other_publication, 1)).to eq 'None, Second'
    end
  end
end
