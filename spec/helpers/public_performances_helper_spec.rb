# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PublicPerformancesHelper, type: :helper do
  let(:public_performance) { FactoryBot.create(:public_performance) }

  describe '#find_public_performances(id)' do
    it 'returns the requested book chapters in an array' do
      expect(helper.find_public_performances(public_performance.submitter_id)).to eq Array.wrap(public_performance)
    end
  end
end
