# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PhotographiesHelper, type: :helper do
  let(:photography) { FactoryBot.create(:photography) }

  describe '#find_photographies(id)' do
    it 'returns the requested photographies in an array' do
      expect(helper.find_photographies(photography.submitter_id)).to eq Array.wrap(photography)
    end
  end
end
