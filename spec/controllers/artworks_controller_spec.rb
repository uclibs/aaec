# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArtworksController, type: :controller do
  let(:valid_attributes) do
    { 'author_first_name' => %w[Test Person], 'author_last_name' => %w[Case 2], 'college_ids' => ['', '1', '4'], 'uc_department' => 'Test', 'work_title' => 'Test', 'other_title' => 'Test', 'location' => 'Test', 'date' => 'Test', 'submitter_id' => submitter.id }
  end

  let(:invalid_attributes) do
    { 'author_first_name' => ['Bad'], 'author_last_name' => [''], 'college_ids' => [''], 'uc_department' => '', 'work_title' => '', 'other_title' => '', 'location' => '', 'date' => '', 'submitter_id' => submitter.id }
  end

  let(:submitter) { FactoryBot.create(:submitter) }
  let(:valid_session) { { submitter_id: submitter.id } }
  let(:artwork) { Artwork.create! valid_attributes }

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
      it 'creates a new Artwork' do
        expect do
          post :create, params: { artwork: valid_attributes }, session: valid_session
        end.to change(Artwork, :count).by(1)
      end

      it 'redirects to the publication index' do
        post :create, params: { artwork: valid_attributes }, session: valid_session
        expect(response).to redirect_to(publications_path)
      end
    end

    context 'with invalid params' do
      it 'does not create a new Artwork' do
        expect do
          post :create, params: { artwork: invalid_attributes }, session: valid_session
        end.not_to change(Artwork, :count)
      end

      it "redirects to the 'new' template with status 'unprocessable_entity'" do
        post :create, params: { artwork: invalid_attributes }, session: valid_session
        expect(response).to render_template(:new)
        expect(response.status).to eql 422
      end
    end
  end

  describe 'PUT #update' do
    before do
      login_as_submitter_of(artwork)
    end

    context 'with valid params' do
      let(:new_attributes) do
        { 'college_ids' => %w[6 7], 'date' => 'new date' }
      end

      it 'updates the requested artwork' do
        put :update, params: { id: artwork.id, artwork: new_attributes }
        artwork.reload
        expect(artwork.author_first_name).to eql %w[Test Person] # verify unchanged
        expect(artwork.date).to eql 'new date'
        expect(artwork.college_ids).to eql [6, 7]
      end

      it 'redirects to the artwork' do
        put :update, params: { id: artwork.id, artwork: valid_attributes }
        expect(response).to redirect_to(artwork)
      end
    end

    context 'with invalid params' do
      it "redirects to the 'edit' template with status 'unprocessable_entity'" do
        put :update, params: { id: artwork.id, artwork: invalid_attributes }
        expect(response).to render_template(:edit)
        expect(response.status).to eql 422
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      artwork
      login_as_submitter_of(artwork)
    end

    it 'destroys the requested artwork' do
      expect do
        delete :destroy, params: { id: artwork.id }
      end.to change(Artwork, :count).by(-1)
    end

    it 'redirects to the publications_path' do
      artwork = Artwork.create! valid_attributes
      delete :destroy, params: { id: artwork.id }
      expect(response).to redirect_to(publications_path)
    end
  end
end
