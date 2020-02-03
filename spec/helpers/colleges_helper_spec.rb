# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CollegesHelper, type: :helper do
  describe '#all_colleges(colleges)' do
    it 'returns the requested colleges in a string' do
      expect(helper.all_colleges([1, 2])).to eq 'Allied Health Sciences, Arts and Sciences '
    end
  end

  describe '#college_name(id)' do
    it 'returns the requested college as a string' do
      expect(helper.college_name(1)).to eq 'Allied Health Sciences'
    end
  end
end
