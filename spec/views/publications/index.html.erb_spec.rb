# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'publications/index', type: :view do
  describe 'Standard Submitter' do
    before do
      assign(:submitter, FactoryBot.create(:submitter))
      controller.params[:submitter_id] = 1
      @artworks = []
      @books = []
      @book_chapters = []
      @editings = []
      @journal_articles = []
      @photographies = []
      @plays = []
      @musical_scores = []
      @physical_media = []
      @digital_projects = []
      @public_performances = []
      @films = []
      @other_publications = []
    end

    it 'renders a list of submitters' do
      render
      expect(rendered).to have_content('First Last', count: 1)
      expect(rendered).to have_content('Arts and Sciences', count: 1)
      expect(rendered).to have_content('Department', count: 1)
      expect(rendered).not_to have_content('Home Address', count: 1)
      expect(rendered).not_to have_content('111-111-1111', count: 1)
      expect(rendered).to have_content('test@mail.uc.edu...', count: 1)
      expect(rendered).to have_content('Books', count: 1)
      expect(rendered).to have_content('Other Publications', count: 1)
      expect(rendered).to have_css('.btn', text: 'New')
    end
  end
end
