# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AdminController, type: :controller do
  let(:common_params) { { 'controller_name' => 'other_publications' } }
  let(:admin_session) { { 'admin' => true } }
  let(:allowed_controllers_to_models) do
    { 'artworks' => Artwork,
      'books' => Book,
      'other_publications' => OtherPublication }
  end

  before do
    stub_const("#{described_class}::ALLOWED_CONTROLLERS_TO_MODELS", allowed_controllers_to_models)
  end

  describe 'GET #csv' do
    it 'returns a 200 status when requesting a CSV format' do
      get(:csv, params: common_params.merge({ format: 'csv' }), session: admin_session)
      expect(response.status).to eq(200)
    end

    it 'redirects when an invalid format is provided' do
      get(:csv, params: common_params.merge({ format: 'jpeg' }), session: admin_session)
      expect(response).to redirect_to('/publications')
    end

    context 'when a StandardError is raised' do
      before do
        allow(OtherPublication).to receive(:to_csv).and_raise(StandardError)
      end

      it 'redirects with a notice' do
        get(:csv, params: common_params.merge({ format: 'csv' }), session: admin_session)
        expect(response).to redirect_to('/publications')
        expect(flash[:danger]).to eq('Something went wrong while generating the CSV.')
      end
    end

    context 'when the model is allowed' do
      let(:mocked_data) { %w[otherPub1 otherPub2] }

      before do
        allow(controller).to receive(:params).and_return(controller_name: 'other_publications')
        allow(OtherPublication).to receive(:all).and_return(mocked_data)
        allow(mocked_data).to receive(:to_csv).and_return('csv_string')
      end

      it 'generates a CSV file' do
        get :csv, params: { controller_name: 'other_publications' }, format: :csv, session: admin_session
        expect(response.body).to eq('csv_string')
      end
    end

    context 'when the model is not allowed' do
      before do
        allow(controller).to receive(:params).and_return(controller_name: 'unknown_controller')
      end

      it 'redirects to the publications_path' do
        get :csv, params: { controller_name: 'unknown_controller' }, session: admin_session
        expect(response).to redirect_to(publications_path)
      end
    end
  end
end
