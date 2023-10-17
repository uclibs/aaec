# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BookChaptersController, type: :controller do
  let(:valid_attributes) do
    { 'author_first_name' => %w[Test Person], 'author_last_name' => %w[Case 2], 'college_ids' => ['', '1', '4'], 'uc_department' => 'Test', 'work_title' => 'Test', 'other_title' => 'Test', 'publisher' => 'Test', 'page_numbers' => 'Test', 'city' => 'Test', 'publication_date' => 'Test', 'url' => 'Test', 'doi' => 'Test' }
  end

  let(:invalid_attributes) do
    { 'author_first_name' => ['Bad'], 'author_last_name' => [''], 'college_ids' => [''], 'uc_department' => '', 'work_title' => '', 'other_title' => '', 'publisher' => '', 'page_numbers' => '', 'city' => '', 'publication_date' => '', 'url' => '', 'doi' => '' }
  end

  let(:submitter) { FactoryBot.create(:submitter) }
  let(:valid_session) { { submitter_id: submitter.id } }

  describe 'GET #index' do
    before do
      FactoryBot.create(:submitter)
    end

    it 'returns a success response' do
      BookChapter.create! valid_attributes
      get :index, session: valid_session
      expect(response).to redirect_to('/publications')
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      book_chapter = BookChapter.create! valid_attributes
      get :show, params: { id: book_chapter.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #show as admin' do
    it 'returns a success response' do
      FactoryBot.create(:submitter)
      session[:admin] = true
      book_chapter = BookChapter.create! valid_attributes
      get :show, params: { id: book_chapter.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      book_chapter = BookChapter.create! valid_attributes
      get :edit, params: { id: book_chapter.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      before do
        FactoryBot.create(:submitter)
      end

      it 'creates a new Other Publication' do
        expect do
          post :create, params: { book_chapter: valid_attributes }, session: valid_session
        end.to change(BookChapter, :count).by(1)
      end

      it 'redirects to the publication index' do
        post :create, params: { book_chapter: valid_attributes }, session: valid_session
        expect(response).to redirect_to(publications_path)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { book_chapter: invalid_attributes }, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        { 'author_first_name' => %w[Test Person], 'author_last_name' => %w[Case 2], 'college_ids' => %w[6 7], 'uc_department' => 'Test', 'work_title' => 'Test', 'other_title' => 'Test', 'volume' => 'Test', 'issue' => 'Test', 'page_numbers' => 'Test', 'publisher' => 'Test', 'city' => 'Test', 'publication_date' => 'Test', 'url' => 'www.cool.com', 'doi' => 'Test' }
      end

      it 'updates the requested other publication' do
        book_chapter = BookChapter.create! valid_attributes
        put :update, params: { id: book_chapter.to_param, book_chapter: new_attributes }, session: valid_session
        book_chapter.reload
        expect(book_chapter.url).to eql 'www.cool.com'
        expect(book_chapter.college_ids).to eql [6, 7]
      end

      it 'redirects to the book_chapter' do
        book_chapter = BookChapter.create! valid_attributes
        put :update, params: { id: book_chapter.to_param, book_chapter: valid_attributes }, session: valid_session
        expect(response).to redirect_to(book_chapter)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        book_chapter = BookChapter.create! valid_attributes
        put :update, params: { id: book_chapter.to_param, book_chapter: invalid_attributes }, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested book_chapter' do
      book_chapter = BookChapter.create! valid_attributes
      expect do
        delete :destroy, params: { id: book_chapter.to_param }, session: valid_session
      end.to change(BookChapter, :count).by(-1)
    end

    it 'redirects to the book_chapters list' do
      book_chapter = BookChapter.create! valid_attributes
      delete :destroy, params: { id: book_chapter.to_param }, session: valid_session
      expect(response).to redirect_to(book_chapters_url)
    end
  end
end
