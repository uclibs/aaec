# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'AdminOnlyAccess Concern', type: :controller do
  controller(ApplicationController) do
    include AdminOnlyAccess

    def dummy_action
      render plain: 'Access granted'
    end
  end

  before do
    routes.draw { get 'dummy_action' => 'anonymous#dummy_action' }
  end

  describe 'GET #dummy_action' do
    context 'as an admin user' do
      before { session[:admin] = true }

      it 'allows access to the action' do
        get :dummy_action
        expect(response.body).to eq('Access granted')
      end
    end

    context 'as a submitter' do
      before do
        session[:admin] = false
        session[:submitter_id] = FactoryBot.create(:submitter).id
      end

      it 'denies access to the action' do
        expect { get :dummy_action }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'as a non-admin user' do
      before { session[:admin] = false }

      it 'redirects the user to log in' do
        get :dummy_action
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
