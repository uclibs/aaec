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
      it 'with invalid params' do
        get :show, params: { page: 'bad' }
        expect(response.status).to eq(404)
        expect(response.body).to have_text('The page you requested cannot be found')
      end
    end
  end

  # When adding a new page, you need to add it to the VALID_PAGES constant in
  # app/controllers/pages_controller.rb. This test ensures that the constant
  # is kept up to date.
  describe 'VALID_PAGES' do
    it 'contains all the pages in app/views/pages' do
      view_pages = Dir[Rails.root.join('app', 'views', 'pages', '*.html.erb')]
                   .map { |path| File.basename(path, '.html.erb') }

      expect(PagesController::VALID_PAGES).to match_array(view_pages)
    end
  end

  describe 'ALLOWED_PAGES constant' do
    it 'contains all the valid pages in app/views/pages' do
      page_files = Dir.glob('app/views/pages/*.html.erb').map do |file|
        File.basename(file, '.html.erb')
      end

      expect(PagesController::ALLOWED_PAGES).to match_array(page_files)
    end
  end
end
