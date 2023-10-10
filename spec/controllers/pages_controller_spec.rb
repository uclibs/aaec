# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe 'GET #show' do
    render_views

    context 'when page is valid' do
      it 'renders the page' do
        get :show, params: { page: 'closed' }
        expect(response).to render_template('pages/closed')
        expect(response.body).to have_text('The deadline for submissions has passed')
      end
    end

    context 'when page is invalid' do
      it 'returns a 404 status' do
        get :show, params: { page: 'bad' }
        expect(response.status).to eq(404)
      end

      it 'renders the 404 template' do
        get :show, params: { page: 'bad' }
        expect(response).to render_template('errors/404')
      end
    end
  end

  # When adding a new page, you need to add it to the ALLOWED_PAGES constant in
  # app/controllers/pages_controller.rb. This test ensures that the constant
  # is kept up to date.
  describe 'ALLOWED_PAGES constant' do
    it 'contains all the valid pages in app/views/pages' do
      page_files = Dir.glob('app/views/pages/*.html.erb').map do |file|
        File.basename(file, '.html.erb')
      end

      expect(PagesController::ALLOWED_PAGES).to match_array(page_files)
    end
  end

  describe '#safe_page' do
    let(:params) { {} }
    let(:allowed_pages) { %w[home about contact] }

    before do
      allow(controller).to receive(:params).and_return(params)
      stub_const("#{PagesController}::ALLOWED_PAGES", allowed_pages)
    end

    it 'returns nil if the page is not in ALLOWED_PAGES' do
      params[:page] = 'unallowed_page'
      expect(controller.send(:safe_page)).to be_nil
    end

    it 'returns the page if it is in ALLOWED_PAGES' do
      params[:page] = 'home'
      expect(controller.send(:safe_page)).to eq('home')
    end
  end
end
