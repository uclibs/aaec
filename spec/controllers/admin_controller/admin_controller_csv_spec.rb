# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AdminController, type: :controller do
  let(:common_params) { { 'controller_name' => 'other_publications' } }
  let(:admin_session) { { 'admin' => true } }

  describe 'GET #csv' do
    context 'when the user is an admin' do
      it 'returns a 200 status when requesting a CSV format' do
        get(:csv, params: common_params.merge({ format: 'csv' }), session: admin_session)
        expect(response.status).to eq(200)
      end

      it 'redirects when an invalid format is provided' do
        get(:csv, params: common_params.merge({ format: 'html' }), session: admin_session)
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
    end

    context 'when the user is not an admin' do
      it 'redirects even if a valid format is provided' do
        get(:csv, params: common_params.merge({ format: 'csv' }))
        expect(response).to redirect_to('/publications')
      end
    end
  end
end
