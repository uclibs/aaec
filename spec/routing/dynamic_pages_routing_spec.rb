# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PagesController, type: :routing do
  describe 'routing' do
    PagesController::ALLOWED_PAGES.each do |page|
      it "routes to #show with #{page} as parameter" do
        expect(get: "/pages/#{page}").to route_to('pages#show', page: page)
      end
    end

    it 'does not route to #show without a page parameter' do
      expect(get: '/pages/').not_to be_routable
    end
  end
end
