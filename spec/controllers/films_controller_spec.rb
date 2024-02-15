# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FilmsController, type: :controller do
  let(:valid_attributes) do
    { 'author_first_name' => %w[Test Person], 'author_last_name' => %w[Case 2], 'college_ids' => ['', '1', '4'], 'uc_department' => 'Test', 'work_title' => 'Test', 'other_title' => 'Test', 'director' => 'Test', 'release_year' => 'Test', 'submitter_id' => submitter.id.to_s }
  end

  let(:invalid_attributes) do
    { 'author_first_name' => ['Bad'], 'author_last_name' => [''], 'college_ids' => [''], 'uc_department' => '', 'work_title' => '', 'other_title' => '', 'director' => '', 'release_year' => '' }
  end

  let(:submitter) { FactoryBot.create(:submitter) }
  let(:film) { FactoryBot.create(:film, submitter_id: submitter.id) }

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
      it 'creates a new Film with the correct submitter_id' do
        expect do
          post :create, params: { film: valid_attributes }
        end.to change(Film, :count).by(1)

        created_film = Film.last
        expect(created_film.submitter_id).to eq(submitter.id.to_s)
      end

      it 'redirects to the publication index' do
        post :create, params: { film: valid_attributes }
        expect(response).to redirect_to(publications_path)
      end
    end

    context 'with invalid params' do
      it 'does not create a new Film' do
        expect do
          post :create, params: { film: invalid_attributes }
        end.not_to change(Film, :count)
      end

      it "redirects to the 'new' template with status 'unprocessable_entity'" do
        post :create, params: { film: invalid_attributes }
        expect(response).to render_template(:new)
        expect(response.status).to eql 422
      end
    end
  end

  describe 'PUT #update' do
    before do
      login_as_submitter_of(film)
    end
    context 'with valid params' do
      let(:new_attributes) do
        { 'college_ids' => %w[6 7], 'release_year' => '2020' }
      end

      it 'updates the requested film' do
        put :update, params: { id: film.id, film: new_attributes }
        film.reload
        expect(film.author_first_name).to eql %w[First Second] # verify unchanged
        expect(film.release_year).to eql '2020'
        expect(film.college_ids).to eql [6, 7]
      end

      it 'redirects to the film' do
        put :update, params: { id: film.id, film: new_attributes }
        expect(response).to redirect_to(film)
      end
    end

    context 'with invalid params' do
      it "redirects to the 'edit' template with status 'unprocessable_entity'" do
        put :update, params: { id: film.id, film: invalid_attributes }
        expect(response).to render_template(:edit)
        expect(response.status).to eql 422
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      film
      login_as_submitter_of(film)
    end

    it 'destroys the requested film' do
      expect do
        delete :destroy, params: { id: film.id }
      end.to change(Film, :count).by(-1)
    end

    it 'redirects to the publications_path' do
      delete :destroy, params: { id: film.id }
      expect(response).to redirect_to(publications_path)
    end
  end
end
