# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AdminController, type: :controller do
  describe 'GET #citations' do
    context 'when admin is logged in' do
      before do
        session[:admin] = true
        mock_college1 = double('College', id: 1)
        mock_college2 = double('College', id: 2)
        allow(College).to receive(:find_each).and_yield(mock_college1).and_yield(mock_college2)
        allow(controller).to receive(:fetch_all_records).and_return(mocked_records)
      end

      let(:mocked_records) { [double('Artwork', college_ids: [1], uc_department: 'Art'), double('Book', college_ids: [2], uc_department: 'Literature')] }

      it 'populates @college_departments_grouped with grouped records' do
        get :citations
        expect(assigns(:college_departments_grouped)).to eq([[1, { 'Art' => [mocked_records.first] }], [2, { 'Literature' => [mocked_records.last] }]])
      end
    end

    context 'when admin is not logged in' do
      before do
        session[:admin] = false
        session[:submitter_id] = FactoryBot.create(:submitter).id
      end

      it 'redirects to publications_path' do
        get :citations
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
