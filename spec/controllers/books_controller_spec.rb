# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  let(:valid_attributes) do
    { 'author_first_name' => %w[Test Person], 'author_last_name' => %w[Case 2], 'college_ids' => ['', '1', '2'], 'uc_department' => 'Dept', 'work_title' => 'WT', 'other_title' => 'OT', 'publisher' => 'Pub', 'city' => 'City', 'publication_date' => 'Today', 'url' => 'www.fake.com', 'doi' => 'doi:', 'submitter_id' => submitter.id }
  end

  let(:invalid_attributes) do
    { 'author_first_name' => ['Bad'], 'author_last_name' => [''], 'college_ids' => [''], 'uc_department' => '', 'work_title' => '', 'other_title' => '', 'publisher' => '', 'city' => '', 'publication_date' => '', 'url' => '', 'doi' => '', 'submitter_id' => submitter.id }
  end

  let(:submitter) { FactoryBot.create(:submitter) }
  let(:valid_session) { { submitter_id: submitter.id } }
  let(:book) { Book.create! valid_attributes }

  it_behaves_like 'restricts non-logged-in users', {
    'index' => :get,
    'show' => :get,
    'new' => :get,
    'edit' => :get,
    'create' => :post,
    'update' => :put,
    'destroy' => :delete
  }

  describe 'POST #create' do
    context 'with valid params' do
      before do
        FactoryBot.create(:submitter)
      end

      it 'creates a new Book' do
        expect do
          post :create, params: { book: valid_attributes }, session: valid_session
        end.to change(Book, :count).by(1)
      end

      it 'redirects to the created book' do
        post :create, params: { book: valid_attributes }, session: valid_session
        expect(response).to redirect_to(publications_path)
      end
    end

    context 'with invalid params' do
      it 'does not create a new Book' do
        expect do
          post :create, params: { book: invalid_attributes }, session: valid_session
        end.not_to change(Book, :count)
      end

      it "redirects to the 'new' template with status 'unprocessable_entity'" do
        post :create, params: { book: invalid_attributes }, session: valid_session
        expect(response).to render_template(:new)
        expect(response.status).to eql 422
      end
    end
  end

  describe 'PUT #update' do
    before do
      login_as_submitter_of(book)
    end
    context 'with valid params' do
      let(:new_attributes) do
        { 'college_ids' => %w[3 4], 'url' => 'www.cool.com' }
      end

      it 'updates the requested book' do
        put :update, params: { id: book.id, book: new_attributes }
        book.reload
        expect(book.author_first_name).to eql %w[Test Person] # verify it is unchanged
        expect(book.url).to eql 'www.cool.com'
        expect(book.college_ids).to eql [3, 4]
      end

      it 'redirects to the book' do
        put :update, params: { id: book.id, book: valid_attributes }
        expect(response).to redirect_to(book)
      end
    end

    context 'with invalid params' do
      it "redirects to the 'edit' template with status 'unprocessable_entity'" do
        put :update, params: { id: book.id, book: invalid_attributes }
        expect(response).to render_template(:edit)
        expect(response.status).to eql 422
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      book
      login_as_submitter_of(book)
    end
    it 'destroys the requested book' do
      expect do
        delete :destroy, params: { id: book.id }
      end.to change(Book, :count).by(-1)
    end

    it 'redirects to the publications_path' do
      book = Book.create! valid_attributes
      delete :destroy, params: { id: book.id }
      expect(response).to redirect_to(publications_path)
    end
  end
end
