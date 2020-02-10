# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe 'Show valid page' do
    render_views

    it 'vith valid params' do
      get :show, params: { page: 'closed' }
      expect(response.body).to have_text('The deadline for submissions has passed')
    end
  end

  describe 'Show invalid page' do
    render_views

    it 'with invalid params' do
      get :show, params: { page: 'bad' }
      expect(response.body).to have_text("The page you were looking for doesn't exist")
    end
  end
end
