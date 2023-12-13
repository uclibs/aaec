# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BookChaptersController, type: :controller do
  let(:valid_attributes) do
    { 'author_first_name' => %w[Test Person], 'author_last_name' => %w[Case 2], 'college_ids' => ['', '1', '4'], 'uc_department' => 'Test', 'work_title' => 'Test', 'other_title' => 'Test', 'publisher' => 'Test', 'page_numbers' => 'Test', 'city' => 'Test', 'publication_date' => 'Test', 'url' => 'Test', 'doi' => 'Test', 'submitter_id' => submitter.id.to_s }
  end

  let(:invalid_attributes) do
    { 'author_first_name' => ['Bad'], 'author_last_name' => [''], 'college_ids' => [''], 'uc_department' => '', 'work_title' => '', 'other_title' => '', 'publisher' => '', 'page_numbers' => '', 'city' => '', 'publication_date' => '', 'url' => '', 'doi' => '' }
  end

  let(:submitter) { FactoryBot.create(:submitter) }
  let(:book_chapter) { FactoryBot.create(:book_chapter, submitter_id: submitter.id) }

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
    before do
      session[:submitter_id] = submitter.id
    end
    context 'with valid params' do
      it 'creates a new BookChapter with the correct submitter_id' do
        expect do
          post :create, params: { book_chapter: valid_attributes }
        end.to change(BookChapter, :count).by(1)

        created_book_chapter = BookChapter.last
        expect(created_book_chapter.submitter_id).to eq(submitter.id.to_s)
      end

      it 'redirects to the publication index' do
        post :create, params: { book_chapter: valid_attributes }
        expect(response).to redirect_to(publications_path)
      end
    end

    context 'with invalid params' do
      it 'does not create a new Book Chapter' do
        expect do
          post :create, params: { book_chapter: invalid_attributes }
        end.not_to change(Artwork, :count)
      end

      it "redirects to the 'new' template with status 'unprocessable_entity'" do
        post :create, params: { book_chapter: invalid_attributes }
        expect(response).to render_template(:new)
        expect(response.status).to eql 422
      end
    end
  end

  describe 'PUT #update' do
    before do
      login_as_submitter_of(book_chapter)
    end
    context 'with valid params' do
      let(:new_attributes) do
        { 'college_ids' => %w[6 7], 'url' => 'www.cool.com' }
      end

      it 'updates the requested book chapter' do
        put :update, params: { id: book_chapter.id, book_chapter: new_attributes }
        book_chapter.reload
        expect(book_chapter.author_first_name).to eql %w[First Second] # verify unchanged
        expect(book_chapter.url).to eql 'www.cool.com'
        expect(book_chapter.college_ids).to eql [6, 7]
      end

      it 'redirects to the book_chapter' do
        put :update, params: { id: book_chapter.id, book_chapter: new_attributes }
        expect(response).to redirect_to(book_chapter)
      end
    end

    context 'with invalid params' do
      it "redirects to the 'edit' template with status 'unprocessable_entity'" do
        put :update, params: { id: book_chapter.id, book_chapter: invalid_attributes }
        expect(response).to render_template(:edit)
        expect(response.status).to eql 422
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      book_chapter
      login_as_submitter_of(book_chapter)
    end

    it 'destroys the requested book_chapter' do
      expect do
        delete :destroy, params: { id: book_chapter.id }
      end.to change(BookChapter, :count).by(-1)
    end

    it 'redirects to the publications_path' do
      delete :destroy, params: { id: book_chapter.id }
      expect(response).to redirect_to(publications_path)
    end
  end
end
