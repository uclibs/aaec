# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '#preprocess_attr' do
  include PublicationsHelper

  let(:publication) do
    double(
      other_title: 'A Study in Ruby',
      volume: 1,
      some_integer: 123,
      some_string: ' hello ',
      nil_field: nil,
      empty_string: ''
    )
  end

  context 'when the attribute exists and is non-blank' do
    it 'returns the attribute value' do
      expect(preprocess_attr(publication, :other_title)).to eq('A Study in Ruby')
    end

    it 'strips extra spaces if the attribute is a string' do
      expect(preprocess_attr(publication, :some_string)).to eq('hello')
    end

    it 'returns nil if the attribute is a number' do
      expect(preprocess_attr(publication, :volume)).to eq(nil)
    end
  end

  context 'when the attribute exists but is blank' do
    it 'returns nil for an empty string' do
      expect(preprocess_attr(publication, :empty_string)).to eq(nil)
    end

    it 'returns nil for a nil value' do
      expect(preprocess_attr(publication, :nil_field)).to eq(nil)
    end
  end

  context 'when the attribute does not exist' do
    it 'returns nil' do
      expect(preprocess_attr(publication, :non_existent_field)).to eq(nil)
    end
  end

  context 'when multiple attributes are provided' do
    it 'returns the first non-blank attribute' do
      expect(preprocess_attr(publication, :nil_field, :empty_string, :some_string)).to eq('hello')
    end

    it 'returns nil if all attributes are blank or do not exist' do
      expect(preprocess_attr(publication, :nil_field, :empty_string, :non_existent_field)).to eq(nil)
    end
  end
end
