# frozen_string_literal: true

# The PublicationsController is responsible for handling the requests for all
# publications.  Each model inherits its CRUD actions from this controller.
# We do not actually have a Publications model, so for testing purposes
# we will use the Book model, which is a child of the Publication model.
#
require 'rails_helper'

# We are calling BooksController, a "child" of PublicationsController, so we
# need to define it here.
RSpec.describe BooksController, type: :controller do
  let(:submitter) { FactoryBot.create(:submitter) }
  let(:another_submitter) { FactoryBot.create(:submitter) }
  let(:book) { FactoryBot.create(:book, submitter_id: submitter.id.to_s) }
  let(:another_book) { FactoryBot.create(:book, submitter_id: another_submitter.id.to_s) }

  before do
    book
  end

  describe 'GET #show' do
    context 'as an admin user' do
      before do
        session[:admin] = true
        get :show, params: { id: book.id }
      end

      it 'sets @submitter correctly' do
        expect(assigns(:submitter).id.to_s).to eq(book.submitter_id)
      end

      it 'renders the show template' do
        expect(response).to render_template(:show)
      end

      context 'when the book does not exist' do
        before do
          session[:admin] = true
        end

        it 'responds with a 404 not found' do
          expect { get :show, params: { id: 'nonexistent' } }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end

    context 'as a submitter' do
      before do
        session[:admin] = nil
        book
        login_as_submitter_of(book)
      end

      context 'who owns the book' do
        it 'does not set @submitter' do
          get :show, params: { id: book.id }
          expect(assigns(:submitter)).to be_nil
        end

        it 'renders the show template' do
          get :show, params: { id: book.id }
          expect(response).to render_template(:show)
        end
      end

      context 'who does not own the book' do
        it 'raises a 404 not found error and does not set submitter' do
          expect { get :show, params: { id: another_book.id } }.to raise_error(ActiveRecord::RecordNotFound)
          expect(assigns(:submitter)).to be_nil
        end
      end
    end
  end
end
