# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AdminController, type: :controller do
  describe '#fetch_all_records' do
    before do
      stub_const('AdminController::ALLOWED_CONTROLLERS_TO_MODELS', {
                   'artworks' => double('ArtworkModel'),
                   'books' => double('BookModel')
                 })
    end

    it 'fetches all records from each allowed model' do
      # Create doubles for the records
      artwork_double = double('ArtworkRecord')
      book_double = double('BookRecord')

      # Allow the models to receive :all and return the doubles
      allow(AdminController::ALLOWED_CONTROLLERS_TO_MODELS['artworks']).to receive(:all).and_return([artwork_double])
      allow(AdminController::ALLOWED_CONTROLLERS_TO_MODELS['books']).to receive(:all).and_return([book_double])

      all_records = subject.send(:fetch_all_records)

      # Verify
      expect(all_records).to match_array([artwork_double, book_double])
    end

    it 'returns an empty array if no records are present' do
      # Allow the models to receive :all and return empty arrays
      allow(AdminController::ALLOWED_CONTROLLERS_TO_MODELS['artworks']).to receive(:all).and_return([])
      allow(AdminController::ALLOWED_CONTROLLERS_TO_MODELS['books']).to receive(:all).and_return([])

      all_records = subject.send(:fetch_all_records)

      # Verify
      expect(all_records).to be_empty
    end
  end
end
