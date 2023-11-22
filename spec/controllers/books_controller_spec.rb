# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  let(:valid_attributes) do
    { 'author_first_name' => %w[Test Person], 'author_last_name' => %w[Case 2], 'college_ids' => ['', '1', '2'], 'uc_department' => 'Dept', 'work_title' => 'WT', 'other_title' => 'OT', 'publisher' => 'Pub', 'city' => 'City', 'publication_date' => 'Today', 'url' => 'www.fake.com', 'doi' => 'doi:' }
  end

  let(:invalid_attributes) do
    { 'author_first_name' => ['Bad'], 'author_last_name' => [''], 'college_ids' => [''], 'uc_department' => '', 'work_title' => '', 'other_title' => '', 'publisher' => '', 'city' => '', 'publication_date' => '', 'url' => '', 'doi' => '' }
  end

  let(:valid_session) { { submitter_id: 1 } }

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
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { book: invalid_attributes }, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        { 'author_first_name' => %w[New Person], 'author_last_name' => %w[Person 2], 'college_ids' => %w[3 4], 'uc_department' => 'Dept', 'work_title' => 'WT', 'other_title' => 'OT', 'publisher' => 'Pub', 'city' => 'City', 'publication_date' => 'Today', 'url' => 'www.cool.com', 'doi' => 'doi:' }
      end

      it 'updates the requested book' do
        book = Book.create! valid_attributes
        put :update, params: { id: book.to_param, book: new_attributes }, session: valid_session
        book.reload
        expect(book.url).to eql 'www.cool.com'
        expect(book.college_ids).to eql [3, 4]
      end

      it 'redirects to the book' do
        book = Book.create! valid_attributes
        put :update, params: { id: book.to_param, book: valid_attributes }, session: valid_session
        expect(response).to redirect_to(book)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        book = Book.create! valid_attributes
        put :update, params: { id: book.to_param, book: invalid_attributes }, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested book' do
      book = Book.create! valid_attributes
      expect do
        delete :destroy, params: { id: book.to_param }, session: valid_session
      end.to change(Book, :count).by(-1)
    end

    it 'redirects to the books list' do
      book = Book.create! valid_attributes
      delete :destroy, params: { id: book.to_param }, session: valid_session
      expect(response).to redirect_to(books_url)
    end
  end
end
