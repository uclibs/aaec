# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FilmsHelper, type: :helper do
  let(:film) { FactoryBot.create(:film) }

  describe '#find_films(id)' do
    it 'returns the requested book chapters in an array' do
      expect(helper.find_films(film.submitter_id)).to eq Array.wrap(film)
    end
  end
end
