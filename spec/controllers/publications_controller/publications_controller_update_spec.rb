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

  let(:new_attributes) do
    { 'author_first_name' => %w[New Person],
      'author_last_name' => %w[Person 2] }
  end

  let(:invalid_attributes) do
    { 'author_first_name' => ['Bad'],
      'author_last_name' => [''] }
  end

  let(:already_created_book_by_submitter) { FactoryBot.create(:book, valid_attributes.merge(submitter_id:)) }
  let(:already_created_book_by_another_submitter) { FactoryBot.create(:book, valid_attributes.merge(submitter_id: another_submitter_id)) }

  describe 'PUT #update' do
    before do
      already_created_book_by_submitter
      already_created_book_by_another_submitter
    end

    context 'when attempting to update a book as a submitter' do
      before do
        login_as_submitter_of(already_created_book_by_submitter)
      end

      context 'and the book belongs to the submitter' do
        context 'and updating with valid params' do
          it 'updates the requested book' do
            put :update, params: { id: already_created_book_by_submitter.id, book: new_attributes }
            already_created_book_by_submitter.reload
            expect(already_created_book_by_submitter.author_first_name).to eql %w[New Person]
            expect(already_created_book_by_submitter.author_last_name).to eql %w[Person 2]
          end

          it 'redirects to the book' do
            put :update, params: { id: already_created_book_by_submitter.id, book: valid_attributes }
            expect(response).to redirect_to(already_created_book_by_submitter)
          end

          it 'displays a success flash notice' do
            put :update, params: { id: already_created_book_by_submitter.to_param, book: valid_attributes }
            expect(flash[:success]).to eql 'Book was successfully updated.'
          end
        end

        context 'and updating with invalid params' do
          it 'does not update the requested book' do
            put :update, params: { id: already_created_book_by_submitter.id, book: invalid_attributes }
            already_created_book_by_submitter.reload
            expect(already_created_book_by_submitter.author_first_name).to eql %w[Test Person]
            expect(already_created_book_by_submitter.author_last_name).to eql %w[Case 2]
          end

          it "redirects to the 'edit' template with status 'unprocessable_entity'" do
            put :update, params: { id: already_created_book_by_submitter.to_param, book: invalid_attributes }
            expect(response).to render_template(:edit)
            expect(response.status).to eql 422
          end
        end
      end

      context 'and the book does not belong to the submitter' do
        it 'does not update the requested book and raises a 404 error' do
          expect do
            put :update, params: { id: already_created_book_by_another_submitter.id, book: new_attributes }
          end
            .to raise_error(ActiveRecord::RecordNotFound)

          already_created_book_by_another_submitter.reload

          expect(already_created_book_by_another_submitter.author_first_name).to eql %w[Test Person]
          expect(already_created_book_by_another_submitter.author_last_name).to eql %w[Case 2]
        end
      end
    end

    context 'when attempting to update a book as an admin' do
      before do
        login_as_admin_unit_test
      end
      it 'updates the requested book' do
        put :update, params: { id: already_created_book_by_submitter.id, book: new_attributes }
        already_created_book_by_submitter.reload
        expect(already_created_book_by_submitter.author_first_name).to eql %w[New Person]
        expect(already_created_book_by_submitter.author_last_name).to eql %w[Person 2]
      end

      it 'redirects to the book' do
        put :update, params: { id: already_created_book_by_submitter.to_param, book: valid_attributes }
        expect(response).to redirect_to(already_created_book_by_submitter)
      end

      it 'displays a success flash notice' do
        put :update, params: { id: already_created_book_by_submitter.to_param, book: valid_attributes }
        expect(flash[:success]).to eql 'Book was successfully updated.'
      end
    end
  end
end
