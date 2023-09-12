# frozen_string_literal: true

# spec/helpers/application_helper_spec.rb

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#signed_in' do
    it 'returns true if admin is signed in' do
      session[:admin] = true
      expect(signed_in).to eq(true)
    end

    it 'returns submitter_id if submitter is signed in' do
      session[:submitter_id] = 5
      expect(signed_in).to eq(5)
    end

    it 'returns nil if no one is signed in' do
      expect(signed_in).to be_nil
    end
  end

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
