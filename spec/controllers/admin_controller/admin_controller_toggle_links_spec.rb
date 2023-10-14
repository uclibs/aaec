# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AdminController, type: :controller do
  describe 'POST #toggle_links' do
    context 'when session[:links] is true' do
      before do
        session[:links] = true
        session[:admin] = true
      end

      it 'toggles session[:links] to false' do
        post :toggle_links
        expect(session[:links]).to be false
      end

      it 'redirects to citations_path' do
        post :toggle_links
        expect(response).to redirect_to(citations_path)
      end
    end

    context 'when session[:links] is false' do
      before do
        session[:links] = false
        session[:admin] = true
      end

      it 'toggles session[:links] to true' do
        post :toggle_links
        expect(session[:links]).to be true
      end

      it 'redirects to citations_path' do
        post :toggle_links
        expect(response).to redirect_to(citations_path)
      end
    end
  end
end
