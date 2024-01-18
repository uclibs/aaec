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

  let(:submitter_id) { submitter.id.to_s }
  let(:another_submitter_id) { another_submitter.id.to_s }

  let(:valid_attributes) do
    { 'author_first_name' => %w[Test Person],
      'author_last_name' => %w[Case 2],
      'college_ids' => ['', '1', '2'],
      'uc_department' => 'Dept',
      'work_title' => 'WT',
      'other_title' => 'OT',
      'publisher' => 'Pub',
      'city' => 'City',
      'publication_date' => 'Today',
      'url' => 'www.fake.com',
      'doi' => 'doi:' }
  end

  let(:already_created_book_by_submitter) { FactoryBot.create(:book, valid_attributes.merge(submitter_id:)) }
  let(:already_created_book_by_another_submitter) { FactoryBot.create(:book, valid_attributes.merge(submitter_id: another_submitter_id)) }

  # We have some custom behavior for the index action.  Firstly, it redirects
  # the user to the publications path.  Then it calls a series of partials
  # that are indexes of each of the publication types.
  describe 'GET #index' do
    before do
      already_created_book_by_submitter
      already_created_book_by_another_submitter
    end

    context 'when a user is logged in as an admin' do
      before do
        login_as_admin
        get :index
      end

      it 'assigns all books to @books' do
        expect(assigns(:books)).to include(already_created_book_by_submitter)
        expect(assigns(:books)).to include(already_created_book_by_another_submitter)
      end

      it 'redirects to publications path' do
        expect(response).to redirect_to(publications_path)
      end
    end

    context 'when a user is logged in as a submitter' do
      before do
        login_as_submitter_of(already_created_book_by_submitter)
        get :index
      end

      it 'assigns only the submitter\'s books to @books' do
        expect(assigns(:books)).to eq([already_created_book_by_submitter])
        expect(assigns(:books)).not_to include(already_created_book_by_another_submitter)
      end

      it 'redirects to publications path' do
        expect(response).to redirect_to(publications_path)
      end
    end
  end
end
