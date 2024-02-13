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

  # Check to make sure that the correct @submitter is set when show is called
  # and that the correct template is rendered when appropriate.
  describe 'GET #show' do
    before do
      already_created_book_by_submitter
      already_created_book_by_another_submitter
    end

    context 'when attempting to view books as a submitter' do
      before do
        login_as_submitter_of(already_created_book_by_submitter)
      end

      context 'and the book belongs to the submitter' do
        it 'leaves @submitter set to the current submitter' do
          expect(assigns(:submitter)).to eql already_created_book_by_submitter.submitter
          get :show, params: { id: already_created_book_by_submitter.id }
          expect(assigns(:submitter)).to eql already_created_book_by_submitter.submitter
        end

        it 'renders the show template' do
          get :show, params: { id: already_created_book_by_submitter.id }
          expect(response).to render_template('show')
        end
      end

      context 'and the book does not belong to the submitter' do
        it 'leaves @submitter set to the current submitter' do
          expect(assigns(:submitter)).to eql already_created_book_by_submitter.submitter
          get :show, params: { id: already_created_book_by_another_submitter.id }
          expect(assigns(:submitter)).to eql already_created_book_by_submitter.submitter
        end

        it 'throws a 404 error' do
          expect { get :show, params: { id: already_created_book_by_another_submitter.id } }
            .to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end

    context 'when attempting to delete books as an admin' do
      before do
        login_as_admin
      end

      it 'sets @submitter to the submitter of the requested book' do
        expect(assigns(:submitter)).to be_nil
        get :show, params: { id: already_created_book_by_submitter.id }
        expect(assigns(:submitter)).to eql already_created_book_by_submitter.submitter

        get :show, params: { id: already_created_book_by_another_submitter.id }
        expect(assigns(:submitter)).to eql already_created_book_by_another_submitter.submitter
      end

      it 'renders the show template' do
        get :show, params: { id: already_created_book_by_submitter.id }
        expect(response).to render_template('show')

        get :show, params: { id: already_created_book_by_another_submitter.id }
        expect(response).to render_template('show')
      end
    end
  end
end
