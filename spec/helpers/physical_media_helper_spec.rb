# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PhysicalMediaHelper, type: :helper do
  let(:physical_medium) { FactoryBot.create(:physical_medium) }

  describe '#find_physical_media(id)' do
    it 'returns the requested book chapters in an array' do
      expect(helper.find_physical_media(physical_medium.submitter_id)).to eq Array.wrap(physical_medium)
    end
  end
end
