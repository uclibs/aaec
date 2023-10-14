# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do

  describe '#shorten_long' do
    it 'shortens a long string' do
      expect(shorten_long('thisisaverylongstringwithmorecharacters')).to eq('thisisaverylongs... ')
    end

    it 'does not shorten a short string' do
      expect(shorten_long('short')).to eq('short ')
    end

    it 'returns an empty string if an empty string is provided' do
      expect(shorten_long('')).to eq('')
    end
  end

  describe '#csv_route' do
    it 'returns the correct csv route' do
      allow(ENV).to receive(:[]).with('RAILS_RELATIVE_URL_ROOT').and_return('/root')
      expect(csv_route('test')).to eq('/root/csv/test.csv')
    end

    it 'returns the correct csv route when ENV is not set' do
      allow(ENV).to receive(:[]).with('RAILS_RELATIVE_URL_ROOT').and_return(nil)
      expect(csv_route('test')).to eq('/csv/test.csv')
    end
  end

  describe '#page_route' do
    it 'returns the correct page route' do
      allow(ENV).to receive(:[]).with('RAILS_RELATIVE_URL_ROOT').and_return('/root')
      expect(page_route('test')).to eq('/root/pages/test')
    end

    it 'returns the correct page route when ENV is not set' do
      allow(ENV).to receive(:[]).with('RAILS_RELATIVE_URL_ROOT').and_return(nil)
      expect(page_route('test')).to eq('/pages/test')
    end
  end
end
