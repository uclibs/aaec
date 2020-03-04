# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BookChaptersHelper, type: :helper do
  let(:book_chapter) { FactoryBot.create(:book_chapter) }

  describe '#find_book_chapters(id)' do
    it 'returns the requested book chapters in an array' do
      expect(helper.find_book_chapters(book_chapter.submitter_id)).to eq Array.wrap(book_chapter)
    end
  end
end
