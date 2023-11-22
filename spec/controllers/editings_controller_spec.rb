# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EditingsController, type: :controller do
  let(:valid_attributes) do
    { 'author_first_name' => %w[Test Person], 'author_last_name' => %w[Case 2], 'college_ids' => ['', '1', '4'], 'uc_department' => 'Test', 'work_title' => 'Test', 'other_title' => 'Test', 'volume' => 'Test', 'issue' => 'Test', 'publisher' => 'Test', 'city' => 'Test', 'publication_date' => 'Test', 'url' => 'Test', 'doi' => 'Test' }
  end

  let(:invalid_attributes) do
    { 'author_first_name' => ['Bad'], 'author_last_name' => [''], 'college_ids' => [''], 'uc_department' => '', 'work_title' => '', 'other_title' => '', 'volume' => '', 'issue' => '', 'publisher' => '', 'city' => '', 'publication_date' => '', 'url' => '', 'doi' => '' }
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

      it 'creates a new Other Publication' do
        expect do
          post :create, params: { editing: valid_attributes }, session: valid_session
        end.to change(Editing, :count).by(1)
      end

      it 'redirects to the publication index' do
        post :create, params: { editing: valid_attributes }, session: valid_session
        expect(response).to redirect_to(publications_path)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { editing: invalid_attributes }, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        { 'author_first_name' => %w[Test Person], 'author_last_name' => %w[Case 2], 'college_ids' => %w[6 7], 'uc_department' => 'Test', 'work_title' => 'Test', 'other_title' => 'Test', 'volume' => 'Test', 'issue' => 'Test', 'publisher' => 'Test', 'city' => 'Test', 'publication_date' => 'Test', 'url' => 'www.cool.com', 'doi' => 'Test' }
      end

      it 'updates the requested other publication' do
        editing = Editing.create! valid_attributes
        put :update, params: { id: editing.to_param, editing: new_attributes }, session: valid_session
        editing.reload
        expect(editing.url).to eql 'www.cool.com'
        expect(editing.college_ids).to eql [6, 7]
      end

      it 'redirects to the editing' do
        editing = Editing.create! valid_attributes
        put :update, params: { id: editing.to_param, editing: valid_attributes }, session: valid_session
        expect(response).to redirect_to(editing)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        editing = Editing.create! valid_attributes
        put :update, params: { id: editing.to_param, editing: invalid_attributes }, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested editing' do
      editing = Editing.create! valid_attributes
      expect do
        delete :destroy, params: { id: editing.to_param }, session: valid_session
      end.to change(Editing, :count).by(-1)
    end

    it 'redirects to the editings list' do
      editing = Editing.create! valid_attributes
      delete :destroy, params: { id: editing.to_param }, session: valid_session
      expect(response).to redirect_to(editings_url)
    end
  end
end
