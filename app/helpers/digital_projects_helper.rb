# frozen_string_literal: true

module DigitalProjectsHelper
  def find_digital_projects(id)
    Array.wrap(DigitalProject.where(submitter_id: id))
  end
end
