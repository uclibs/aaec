# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CollegesHelper, type: :helper do
  describe '#all_colleges(colleges)' do
    it 'returns the requested colleges in a string' do
      expect(helper.all_colleges([1, 2])).to eq 'Allied Health Sciences, Arts and Sciences'
    end
  end

  describe '#college_name(id)' do
    it 'returns nil as empty sting' do
      expect(helper.college_name(nil)).to eq ''
    end

    it 'returns the requested college as a string' do
      expect(helper.college_name(1)).to eq 'Allied Health Sciences'
    end
  end

  describe '#college_array(publication)' do
    let(:other_publication) { FactoryBot.create(:other_publication) }
    it 'returns the requested colleges as an array' do
      expect(helper.college_array(other_publication)).to eq ['Arts and Sciences', 'Other: Test']
    end
  end
end
