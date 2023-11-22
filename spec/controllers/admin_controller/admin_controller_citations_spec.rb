# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AdminController, type: :controller do
  describe 'GET #citations' do
    context 'when admin is logged in' do
      before do
        allow(College).to receive(:count).and_return(2)
        allow(controller).to receive(:session).and_return(admin: true)
        allow(controller).to receive(:fetch_all_records).and_return(mocked_records)
      end

      let(:mocked_records) { [double('Artwork', college_ids: [1], uc_department: 'Art'), double('Book', college_ids: [2], uc_department: 'Literature')] }

      it 'populates @college_array with grouped records' do
        get :citations
        expect(assigns(:college_array)).to eq([[1, { 'Art' => [mocked_records.first] }], [2, { 'Literature' => [mocked_records.last] }]])
      end
    end

    context 'when admin is not logged in' do
      before do
        session[:admin] = false
        session[:submitter_id] = FactoryBot.create(:submitter).id
      end

      it 'redirects to publications_path' do
        get :citations
        expect(response).to redirect_to(publications_path)
      end
    end
  end
end
