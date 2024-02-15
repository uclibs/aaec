# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PlaysController, type: :controller do
  let(:valid_attributes) do
    { 'author_first_name' => %w[Test Person], 'author_last_name' => %w[Case 2], 'college_ids' => ['', '1', '4'], 'uc_department' => 'Test', 'work_title' => 'Test', 'other_title' => 'Test', 'publisher' => 'Test', 'city' => 'Test', 'publication_date' => 'Test', 'url' => 'Test', 'doi' => 'Test', 'submitter_id' => submitter.id.to_s }
  end

  let(:invalid_attributes) do
    { 'author_first_name' => ['Bad'], 'author_last_name' => [''], 'college_ids' => [''], 'uc_department' => '', 'work_title' => '', 'other_title' => '', 'publisher' => '', 'city' => '', 'publication_date' => '', 'url' => '', 'doi' => '' }
  end

  let(:submitter) { FactoryBot.create(:submitter) }
  let(:play) { FactoryBot.create(:play, submitter_id: submitter.id) }

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
      it 'creates a new Play with the correct submitter_id' do
        expect do
          post :create, params: { play: valid_attributes }
        end.to change(Play, :count).by(1)

        created_play = Play.last
        expect(created_play.submitter_id).to eq(submitter.id.to_s)
      end

      it 'redirects to the publication index' do
        post :create, params: { play: valid_attributes }
        expect(response).to redirect_to(publications_path)
      end
    end

    context 'with invalid params' do
      it 'does not create a new Play' do
        expect do
          post :create, params: { play: invalid_attributes }
        end.not_to change(Play, :count)
      end

      it "redirects to the 'new' template with status 'unprocessable_entity'" do
        post :create, params: { play: invalid_attributes }
        expect(response).to render_template(:new)
        expect(response.status).to eql 422
      end
    end
  end

  describe 'PUT #update' do
    before do
      login_as_submitter_of(play)
    end

    context 'with valid params' do
      let(:new_attributes) do
        { 'college_ids' => %w[6 7], 'url' => 'www.cool.com' }
      end

      it 'updates the requested play' do
        put :update, params: { id: play.id, play: new_attributes }
        play.reload
        expect(play.author_first_name).to eql %w[First Second] # verify unchanged
        expect(play.url).to eql 'www.cool.com'
        expect(play.college_ids).to eql [6, 7]
      end

      it 'redirects to the play' do
        put :update, params: { id: play.id, play: new_attributes }
        expect(response).to redirect_to(play)
      end
    end

    context 'with invalid params' do
      it "redirects to the 'edit' template with status 'unprocessable_entity'" do
        put :update, params: { id: play.id, play: invalid_attributes }
        expect(response).to render_template(:edit)
        expect(response.status).to eql 422
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      play
      login_as_submitter_of(play)
    end

    it 'destroys the requested play' do
      expect do
        delete :destroy, params: { id: play.id }
      end.to change(Play, :count).by(-1)
    end

    it 'redirects to the publications page' do
      delete :destroy, params: { id: play.id }
      expect(response).to redirect_to(publications_url)
    end
  end
end
