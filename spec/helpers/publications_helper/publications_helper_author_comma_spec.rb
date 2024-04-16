# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PublicationsHelper, type: :helper do
  let(:other_publication) { FactoryBot.create(:other_publication) }

  describe '#author_comma(publication, position)' do
    it 'returns the author comma separated for a specific position in a string' do
      expect(helper.author_comma(other_publication, 1)).to eq 'None, Second'
    end
  end
end
