# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PublicationsHelper, type: :helper do
  let(:other_publication) { FactoryBot.create(:other_publication) }

  describe '#author_name(publication, position)' do
    it 'returns the author for a specific position in a string' do
      expect(helper.author_name(other_publication, 1)).to eq 'Second None'
    end
  end
end
