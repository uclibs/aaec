# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  let(:submitter) { FactoryBot.create(:submitter) }
  let(:another_submitter) { FactoryBot.create(:submitter) }
  let(:book) { FactoryBot.create(:book, submitter_id: submitter.id) }

  describe '#submitter_owned_content_guard' do
    context 'when admin is logged in' do
      before { session[:admin] = true }

      it 'allows access to show' do
        get :show, params: { id: book.id }
        expect(response).to have_http_status(:ok)
      end

      it 'allows access to edit' do
        get :edit, params: { id: book.id }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when submitter owns the resource' do
      before { session[:submitter_id] = submitter.id }

      it 'allows access to show' do
        get :show, params: { id: book.id }
        expect(response).to have_http_status(:ok)
      end

      it 'allows access to edit' do
        get :edit, params: { id: book.id }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when another submitter is logged in' do
      before { session[:submitter_id] = another_submitter.id }

      it 'restricts access to show' do
        expect { get :show, params: { id: book.id } }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it 'restricts access to edit' do
        expect { get :edit, params: { id: book.id } }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when no user is logged in' do
      # Not tested because this scenario is handled by the UserAuthentication concern.
    end
  end
end
