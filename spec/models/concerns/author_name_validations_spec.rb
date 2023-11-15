# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:book) { Book.new(work_title: 'Default Title') }

  describe 'validations' do
    context 'when author names are empty or contain blank entries' do
      it 'is not valid with empty first names' do
        book.author_first_name = []
        book.author_last_name = ['Doe']
        expect(book).not_to be_valid
        expect(book.errors[:author_first_name]).to include("can't be empty or contain blank entries")
      end

      it 'is not valid with blank first names' do
        book.author_first_name = ['']
        book.author_last_name = ['Doe']
        expect(book).not_to be_valid
        expect(book.errors[:author_first_name]).to include("can't be empty or contain blank entries")
      end

      it 'is not valid with empty last names' do
        book.author_first_name = ['John']
        book.author_last_name = []
        expect(book).not_to be_valid
        expect(book.errors[:author_last_name]).to include("can't be empty or contain blank entries")
      end

      it 'is not valid with blank last names' do
        book.author_first_name = ['John']
        book.author_last_name = ['']
        expect(book).not_to be_valid
        expect(book.errors[:author_last_name]).to include("can't be empty or contain blank entries")
      end
    end

    context 'when author names arrays are of unequal length' do
      it 'is not valid if first and last names have different number of entries' do
        book.author_first_name = %w[John Jane]
        book.author_last_name = ['Doe']
        expect(book).not_to be_valid
        expect(book.errors[:base]).to include('Both first and last names are required and must have the same number of entries')
      end
    end

    # Additional context for valid cases
    context 'when author names are valid' do
      it 'is valid with equal number of first and last names' do
        book.author_first_name = %w[John Jane]
        book.author_last_name = %w[Doe Doe]
        expect(book).to be_valid
      end

      it 'is valid with one author' do
        book.author_first_name = ['John']
        book.author_last_name = ['Doe']
        expect(book).to be_valid
      end
    end
  end
end
