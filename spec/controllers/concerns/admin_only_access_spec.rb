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

    context 'as a non-admin user' do
      before { session[:admin] = false }

      it 'denies access to the action' do
        get :dummy_action
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
