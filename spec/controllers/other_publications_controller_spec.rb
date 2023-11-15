# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OtherPublicationsController, type: :controller do
  let(:valid_attributes) do
    { 'author_first_name' => %w[Test Person], 'author_last_name' => %w[Case 2], 'college_ids' => ['', '1', '4'], 'uc_department' => 'Test', 'work_title' => 'Test', 'other_title' => 'Test', 'volume' => 'Test', 'issue' => 'Test', 'page_numbers' => 'Test', 'publisher' => 'Test', 'city' => 'Test', 'publication_date' => 'Test', 'url' => 'Test', 'doi' => 'Test' }
  end

  let(:invalid_attributes) do
    { 'author_first_name' => ['Bad'], 'author_last_name' => [''], 'college_ids' => [''], 'uc_department' => '', 'work_title' => '', 'other_title' => '', 'volume' => '', 'issue' => '', 'page_numbers' => '', 'publisher' => '', 'city' => '', 'publication_date' => '', 'url' => '', 'doi' => '' }
  end

  let(:submitter) { FactoryBot.create(:submitter) }
  let(:valid_session) { { submitter_id: submitter.id } }
  let(:other_publication) { OtherPublication.create! valid_attributes }

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

      it 'creates a new Other Publication' do
        expect do
          post :create, params: { other_publication: valid_attributes }, session: valid_session
        end.to change(OtherPublication, :count).by(1)
      end

      it 'redirects to the publication index' do
        post :create, params: { other_publication: valid_attributes }, session: valid_session
        expect(response).to redirect_to(publications_path)
      end
    end

    context 'with invalid params' do
      it 'does not create a new OtherPublication' do
        expect do
          post :create, params: { other_publication: invalid_attributes }, session: valid_session
        end.not_to change(OtherPublication, :count)
      end

      it "redirects to the 'new' template with status 'unprocessable_entity'" do
        post :create, params: { other_publication: invalid_attributes }, session: valid_session
        expect(response).to render_template(:new)
        expect(response.status).to eql 422
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        { 'author_first_name' => %w[Test Person], 'author_last_name' => %w[Case 2], 'college_ids' => %w[6 7], 'uc_department' => 'Test', 'work_title' => 'Test', 'other_title' => 'Test', 'volume' => 'Test', 'issue' => 'Test', 'page_numbers' => 'Test', 'publisher' => 'Test', 'city' => 'Test', 'publication_date' => 'Test', 'url' => 'www.cool.com', 'doi' => 'Test' }
      end

      it 'updates the requested other publication' do
        put :update, params: { id: other_publication.to_param, other_publication: new_attributes }, session: valid_session
        other_publication.reload
        expect(other_publication.url).to eql 'www.cool.com'
        expect(other_publication.college_ids).to eql [6, 7]
      end

      it 'redirects to the other_publication' do
        put :update, params: { id: other_publication.to_param, other_publication: valid_attributes }, session: valid_session
        expect(response).to redirect_to(other_publication)
      end
    end

    context 'with invalid params' do
      it "redirects to the 'edit' template with status 'unprocessable_entity'" do
        put :update, params: { id: other_publication.to_param, other_publication: invalid_attributes }, session: valid_session
        expect(response).to render_template(:edit)
        expect(response.status).to eql 422
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      other_publication
    end

    it 'destroys the requested other_publication' do
      expect do
        delete :destroy, params: { id: other_publication.to_param }, session: valid_session
      end.to change(OtherPublication, :count).by(-1)
    end

    it 'redirects to the publications_path' do
      other_publication = OtherPublication.create! valid_attributes
      delete :destroy, params: { id: other_publication.to_param }, session: valid_session
      expect(response).to redirect_to(publications_path)
    end
  end
end
