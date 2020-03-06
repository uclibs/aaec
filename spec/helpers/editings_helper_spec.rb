# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EditingsHelper, type: :helper do
  let(:editing) { FactoryBot.create(:editing) }

  describe '#find_editings(id)' do
    it 'returns the requested editings in an array' do
      expect(helper.find_editings(editing.submitter_id)).to eq Array.wrap(editing)
    end
  end
end
