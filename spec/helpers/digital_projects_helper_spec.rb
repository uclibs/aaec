# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DigitalProjectsHelper, type: :helper do
  let(:digital_project) { FactoryBot.create(:digital_project) }

  describe '#find_digital_projects(id)' do
    it 'returns the requested book chapters in an array' do
      expect(helper.find_digital_projects(digital_project.submitter_id)).to eq Array.wrap(digital_project)
    end
  end
end
