# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PublicationsHelper, type: :helper do
  let(:other_publication) { FactoryBot.create(:other_publication) }

  describe '#all_authors(publication)' do
    it 'returns all authors for a work in a string' do
      expect(helper.all_authors(other_publication)).to eq 'First Last, Second None '
    end
  end
end
