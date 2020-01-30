# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BooksHelper, type: :helper do
  let(:book) { FactoryBot.create(:book) }

  describe '#find_books(id)' do
    it 'returns the requested book in an array' do
      expect(helper.find_books(book.submitter_id)).to eq Array.wrap(book)
    end
  end
end
