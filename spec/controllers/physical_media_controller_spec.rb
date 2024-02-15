# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PhysicalMediaController, type: :controller do
  let(:valid_attributes) do
    { 'author_first_name' => %w[Test Person], 'author_last_name' => %w[Case 2], 'college_ids' => ['', '1', '4'], 'uc_department' => 'Test', 'work_title' => 'Test', 'other_title' => 'Test', 'publisher' => 'Test', 'city' => 'Test', 'publication_date' => 'Test', 'url' => 'Test', 'doi' => 'Test', 'submitter_id' => submitter.id.to_s }
  end

  let(:invalid_attributes) do
    { 'author_first_name' => ['Bad'], 'author_last_name' => [''], 'college_ids' => [''], 'uc_department' => '', 'work_title' => '', 'other_title' => '', 'publisher' => '', 'city' => '', 'publication_date' => '', 'url' => '', 'doi' => '' }
  end

  let(:submitter) { FactoryBot.create(:submitter) }
  let(:physical_medium) { FactoryBot.create(:physical_medium, submitter_id: submitter.id) }

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
      it 'creates a new PysicalMedium with the correct submitter_id' do
        expect do
          post :create, params: { physical_medium: valid_attributes }
        end.to change(PhysicalMedium, :count).by(1)

        created_physical_medium = PhysicalMedium.last
        expect(created_physical_medium.submitter_id).to eq(submitter.id.to_s)
      end

      it 'redirects to the publication index' do
        post :create, params: { physical_medium: valid_attributes }
        expect(response).to redirect_to(publications_path)
      end
    end

    context 'with invalid params' do
      it 'does not create a new PhysicalMedium' do
        expect do
          post :create, params: { physical_medium: invalid_attributes }
        end.not_to change(PhysicalMedium, :count)
      end

      it "redirects to the 'new' template with status 'unprocessable_entity'" do
        post :create, params: { physical_medium: invalid_attributes }
        expect(response).to render_template(:new)
        expect(response.status).to eql 422
      end
    end
  end

  describe 'PUT #update' do
    before do
      login_as_submitter_of(physical_medium)
    end

    context 'with valid params' do
      let(:new_attributes) do
        { 'college_ids' => %w[6 7], 'url' => 'www.cool.com' }
      end

      it 'updates the requested physical medium' do
        put :update, params: { id: physical_medium.id, physical_medium: new_attributes }
        physical_medium.reload
        expect(physical_medium.author_first_name).to eql %w[First Second] # verify unchanged
        expect(physical_medium.url).to eql 'www.cool.com'
        expect(physical_medium.college_ids).to eql [6, 7]
      end

      it 'redirects to the physical_medium' do
        put :update, params: { id: physical_medium.id, physical_medium: new_attributes }
        expect(response).to redirect_to(physical_medium)
      end
    end

    context 'with invalid params' do
      it "redirects to the 'edit' template with status 'unprocessable_entity'" do
        put :update, params: { id: physical_medium.id, physical_medium: invalid_attributes }
        expect(response).to render_template(:edit)
        expect(response.status).to eql 422
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      physical_medium
      login_as_submitter_of(physical_medium)
    end

    it 'destroys the requested physical_medium' do
      expect do
        delete :destroy, params: { id: physical_medium.id }
      end.to change(PhysicalMedium, :count).by(-1)
    end

    it 'redirects to the publications_path' do
      delete :destroy, params: { id: physical_medium.id }
      expect(response).to redirect_to(publications_path)
    end
  end
end
