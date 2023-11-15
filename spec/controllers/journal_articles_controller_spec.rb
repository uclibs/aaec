# frozen_string_literal: true

require 'rails_helper'

RSpec.describe JournalArticlesController, type: :controller do
  let(:valid_attributes) do
    { 'author_first_name' => %w[Test Person], 'author_last_name' => %w[Case 2], 'college_ids' => ['', '1', '4'], 'uc_department' => 'Test', 'work_title' => 'Test', 'other_title' => 'Test', 'volume' => 'Test', 'issue' => 'Test', 'page_numbers' => 'Test', 'publication_date' => 'Test', 'url' => 'Test', 'doi' => 'Test' }
  end

  let(:invalid_attributes) do
    { 'author_first_name' => ['Bad'], 'author_last_name' => [''], 'college_ids' => [''], 'uc_department' => '', 'work_title' => '', 'other_title' => '', 'volume' => '', 'issue' => '', 'page_numbers' => '', 'publication_date' => '', 'url' => '', 'doi' => '' }
  end

  let(:submitter) { FactoryBot.create(:submitter) }
  let(:valid_session) { { submitter_id: submitter.id } }
  let(:journal_article) { JournalArticle.create! valid_attributes }

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

      it 'creates a new JournalArticle' do
        expect do
          post :create, params: { journal_article: valid_attributes }, session: valid_session
        end.to change(JournalArticle, :count).by(1)
      end

      it 'redirects to the publication index' do
        post :create, params: { journal_article: valid_attributes }, session: valid_session
        expect(response).to redirect_to(publications_path)
      end
    end

    context 'with invalid params' do
      it 'does not create a new Journal Article' do
        expect do
          post :create, params: { journal_article: invalid_attributes }, session: valid_session
        end.not_to change(JournalArticle, :count)
      end

      it "redirects to the 'new' template with status 'unprocessable_entity'" do
        post :create, params: { journal_article: invalid_attributes }, session: valid_session
        expect(response).to render_template(:new)
        expect(response.status).to eql 422
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        { 'author_first_name' => %w[Test Person], 'author_last_name' => %w[Case 2], 'college_ids' => %w[6 7], 'uc_department' => 'Test', 'work_title' => 'Test', 'other_title' => 'Test', 'volume' => 'Test', 'issue' => 'Test', 'page_numbers' => 'Test', 'publication_date' => 'Test', 'url' => 'www.cool.com', 'doi' => 'Test' }
      end

      it 'updates the requested other publication' do
        put :update, params: { id: journal_article.to_param, journal_article: new_attributes }, session: valid_session
        journal_article.reload
        expect(journal_article.url).to eql 'www.cool.com'
        expect(journal_article.college_ids).to eql [6, 7]
      end

      it 'redirects to the journal_article' do
        put :update, params: { id: journal_article.to_param, journal_article: valid_attributes }, session: valid_session
        expect(response).to redirect_to(journal_article)
      end
    end

    context 'with invalid params' do
      it "redirects to the 'edit' template with status 'unprocessable_entity'" do
        put :update, params: { id: journal_article.to_param, journal_article: invalid_attributes }, session: valid_session
        expect(response).to render_template(:edit)
        expect(response.status).to eql 422
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      journal_article
    end

    it 'destroys the requested journal_article' do
      expect do
        delete :destroy, params: { id: journal_article.to_param }, session: valid_session
      end.to change(JournalArticle, :count).by(-1)
    end

    it 'redirects to the publications_path' do
      journal_article = JournalArticle.create! valid_attributes
      delete :destroy, params: { id: journal_article.to_param }, session: valid_session
      expect(response).to redirect_to(publications_path)
    end
  end
end
