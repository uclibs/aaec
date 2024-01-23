# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Application Behavior', type: :feature do
  let(:submitter) { FactoryBot.build(:submitter) }

  before do
    allow(ENV).to receive(:fetch).with('EXPIRATION_DATE').and_return('Jan 01 2000')
  end

  context 'when accessing outside open dates and with a missing or invalid session ID' do
    it 'redirects to the closed page' do
      visit publications_path
      expect(page).to have_content('The deadline for submissions has passed.')
    end
  end
end
