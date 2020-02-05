# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SubmittersHelper, type: :helper do
  let(:submitter) { FactoryBot.create(:submitter) }

  describe '#find_submitter(id)' do
    it 'returns the specified user' do
      expect(helper.find_submitter(submitter.id)).to eq submitter
    end
  end

  describe '#find_submitters(id)' do
    it 'returns the specified user as an array' do
      expect(helper.find_submitters(submitter.id)).to eq Array.wrap(submitter)
    end
  end
end
