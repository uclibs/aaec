# frozen_string_literal: true

# The PublicationsController is responsible for handling the requests for all
# publications.  Each model inherits its CRUD actions from this controller.
# We do not actually have a Publications model, so for testing purposes
# we will use the Book model, which is a child of the Publication model.
#
require 'rails_helper'

# We are calling BooksController, a "child" of PublicationsController, so we
# need to define it here.
RSpec.describe BooksController, type: :controller do
  let(:submitter) { FactoryBot.create(:submitter) }
  let(:another_submitter) { FactoryBot.create(:submitter) }

  let(:submitter_id) { submitter.id.to_s }
  let(:another_submitter_id) { another_submitter.id.to_s }

  let(:valid_attributes) do
    { 'author_first_name' => %w[Test Person],
      'author_last_name' => %w[Case 2],
      'college_ids' => ['', '1', '2'],
      'uc_department' => 'Dept',
      'work_title' => 'WT',
      'other_title' => 'OT',
      'publisher' => 'Pub',
      'city' => 'City',
      'publication_date' => 'Today',
      'url' => 'www.fake.com',
      'doi' => 'doi:' }
  end

  let(:already_created_book_by_submitter) { FactoryBot.create(:book, valid_attributes.merge(submitter_id:)) }
  let(:already_created_book_by_another_submitter) { FactoryBot.create(:book, valid_attributes.merge(submitter_id: another_submitter_id)) }

  describe 'DELETE #destroy' do
    before do
      already_created_book_by_submitter
      already_created_book_by_another_submitter
    end

    context 'when attempting to delete books as a submitter' do
      before do
        login_as_submitter_of(already_created_book_by_submitter)
      end

      context 'and the book belongs to the submitter' do
        it 'destroys only the requested book' do
          expect { Book.find(already_created_book_by_submitter.id) }.not_to raise_error
          expect do
            delete :destroy, params: { id: already_created_book_by_submitter.id }
          end.to change(Book, :count).by(-1)
          expect { Book.find(already_created_book_by_submitter.id) }.to raise_error(ActiveRecord::RecordNotFound)
        end

        it 'redirects to the publications_path' do
          delete :destroy, params: { id: already_created_book_by_submitter.id }
          expect(response).to redirect_to(publications_path)
        end

        it 'displays a success flash notice' do
          delete :destroy, params: { id: already_created_book_by_submitter.id }
          expect(flash[:warning]).to eql 'Book was successfully destroyed.'
        end
      end

      context 'and the book does not belong to the submitter' do
        it 'does not destroy the requested book' do
          skip 'waiting for related logic to be merged from PR # 323'
          expect { Book.find(already_created_book_by_another_submitter.id) }.not_to raise_error
          expect do
            delete :destroy, params: { id: already_created_book_by_another_submitter.id }
          end.not_to change(Book, :count)
          expect { Book.find(already_created_book_by_another_submitter.id) }.not_to raise_error
        end

        it 'redirects to the publications_path' do
          skip 'waiting for related logic to be merged from PR # 323'
          delete :destroy, params: { id: already_created_book_by_another_submitter.id }
          expect(response).to redirect_to(publications_path)
        end

        it 'displays a flash alert' do
          skip 'waiting for related logic to be merged from PR # 323'
          delete :destroy, params: { id: already_created_book_by_another_submitter.id }
          expect(flash[:danger]).to eql 'You are not authorized to delete this publication.'
        end
      end
    end

    context 'when attempting to delete books as an admin' do
      before do
        login_as_admin
      end

      it 'destroys the requested books by either submitter' do
        expect { Book.find(already_created_book_by_submitter.id) }.not_to raise_error
        expect { Book.find(already_created_book_by_another_submitter.id) }.not_to raise_error

        expect do
          delete :destroy, params: { id: already_created_book_by_submitter.id }
        end.to change(Book, :count).by(-1)
        expect do
          delete :destroy, params: { id: already_created_book_by_another_submitter.id }
        end.to change(Book, :count).by(-1)

        expect do
          Book.find(already_created_book_by_submitter.id)
        end.to raise_error(ActiveRecord::RecordNotFound)
        expect do
          Book.find(already_created_book_by_another_submitter.id)
        end.to raise_error(ActiveRecord::RecordNotFound)
      end

      it 'redirects to the publications_path' do
        delete :destroy, params: { id: already_created_book_by_submitter.id }
        expect(response).to redirect_to(publications_path)
      end

      it 'displays a success flash notice' do
        delete :destroy, params: { id: already_created_book_by_submitter.id }
        expect(flash[:warning]).to eql 'Book was successfully destroyed.'
      end
    end
  end
end
