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

  let(:invalid_attributes) do
    { 'author_first_name' => ['Bad'],
      'author_last_name' => [''],
      'college_ids' => [''],
      'uc_department' => '',
      'work_title' => '',
      'other_title' => '',
      'publisher' => '',
      'city' => '',
      'publication_date' => '',
      'url' => '',
      'doi' => '' }
  end

  let(:already_created_book_by_submitter) { FactoryBot.create(:book, valid_attributes.merge(submitter_id:)) }
  let(:already_created_book_by_another_submitter) { FactoryBot.create(:book, valid_attributes.merge(submitter_id: another_submitter_id)) }

  describe 'POST #create' do
    before do
      already_created_book_by_submitter
      login_as_submitter_of(already_created_book_by_submitter)
    end

    context 'with valid params' do
      it 'creates a new Book' do
        expect do
          post :create, params: { book: valid_attributes }
        end.to change(Book, :count).by(1)
      end

      it 'redirects to the publications path after creation' do
        post :create, params: { book: valid_attributes }
        expect(response).to redirect_to(publications_path)
      end
    end

    context 'with invalid params' do
      it 'does not create a new Book' do
        expect do
          post :create, params: { book: invalid_attributes }
        end.not_to change(Book, :count)
      end

      it "redirects to the 'new' template with status 'unprocessable_entity'" do
        post :create, params: { book: invalid_attributes }
        expect(response).to render_template(:new)
        expect(response.status).to eql 422
      end
    end
  end
end
