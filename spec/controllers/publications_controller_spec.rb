# frozen_string_literal: true

# The PublicationsController serves as a parent class and is not directly
# responsible for handling HTTP requests except publications/index.
#  Its child controllers, such as BooksController and JournalArticlesController
#  are the ones that actually interact with the user.
#
# As a result, most of the CRUD actions are tested within their respective
# child controller test suites. The only exception is the #index action,
# which is implemented directly in the PublicationsController and is
# therefore tested here.
#
# By ensuring that all child controllers pass their tests, we indirectly
# verify that the shared logic in the PublicationsController is functioning
# as expected.

require 'rails_helper'

RSpec.describe PublicationsController, type: :controller do
  before do
    (1..20).each do |i|
      submitter = Submitter.find_or_create_by(id: i) do |s|
        attributes = FactoryBot.attributes_for(:submitter)
        s.assign_attributes(attributes)
      end
      FactoryBot.create(:book, submitter:)
      FactoryBot.create(:other_publication, submitter:)
      FactoryBot.create(:journal_article, submitter:)
    end
  end

  describe 'GET #index' do
    context 'when the user is an admin' do
      before { session[:admin] = true }

      it 'loads all resources for admin if params[:id] is nil' do
        get :index
        expect(assigns(:books).map(&:id)).to eq(Book.all.limit(10).map(&:id))
        expect(assigns(:book_count)).to eq(20)
        expect(assigns(:journal_articles).map(&:id)).to eq(JournalArticle.all.limit(10).map(&:id))
        expect(assigns(:journal_article_count)).to eq(20)
        expect(assigns(:other_publications).map(&:id)).to eq(OtherPublication.all.limit(10).map(&:id))
        expect(assigns(:other_publication_count)).to eq(20)
        expect(assigns(:artworks)).to eq([]) # Assuming no artworks were created
        expect(assigns(:artwork_count)).to eq(0)
        expect(assigns(:submitters).map(&:id)).to eq(Submitter.all.limit(10).map(&:id))
        expect(assigns(:submitter_count)).to eq(20)

        expect(response).to render_template('index')
      end

      it 'loads single submitter resources for admin if params[:id] is present' do
        get :index, params: { id: Submitter.first.id }

        submitter_id = Submitter.first.id
        expect(assigns(:books)).to eq(Book.where(submitter_id:))
        expect(assigns(:book_count)).to eq(1)
        expect(assigns(:journal_articles)).to eq(JournalArticle.where(submitter_id:))
        expect(assigns(:journal_article_count)).to eq(1)
        expect(assigns(:other_publications)).to eq(OtherPublication.where(submitter_id:))
        expect(assigns(:other_publication_count)).to eq(1)
        expect(assigns(:artworks)).to eq([]) # Assuming no artworks were created
        expect(assigns(:artwork_count)).to eq(0)
        expect(assigns(:submitter)).to eq(Submitter.first)
      end
    end

    context 'when the user is a submitter' do
      before do
        login_as_submitter_of(Book.first)
      end

      it 'loads submitter resources' do
        get :index

        expect(assigns(:books).count).to eq(1)
        expect(assigns(:journal_articles).count).to eq(1)
        expect(assigns(:other_publications).count).to eq(1)
        expect(assigns(:artworks)).to eq([]) # Artworks weren't created
        expect(assigns(:submitter)).to eq(Submitter.first)
      end
    end
  end
end
