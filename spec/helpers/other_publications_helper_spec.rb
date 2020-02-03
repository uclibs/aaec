# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OtherPublicationsHelper, type: :helper do
  let(:other_publication) { FactoryBot.create(:other_publication) }

  describe '#other_publication(id)' do
    it 'returns the requested other publication in an array' do
      expect(helper.find_other_publications(other_publication.submitter_id)).to eq Array.wrap(other_publication)
    end
  end
end
