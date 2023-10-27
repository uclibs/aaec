# frozen_string_literal: true

require 'rails_helper'
require 'support/shared_publication_examples/main_shared_examples'

RSpec.describe ArtworksController, type: :controller do
  it_behaves_like 'a standard publication controller', {
    model_name: :artwork,
    valid_params: {
      uc_department: 'Art Department',
      other_college: 'College of Arts',
      work_title: 'Amazing Artwork',
      other_title: 'Another Title',
      location: 'Art Gallery',
      date: '2021-10-15',
      submitter_id: 1,
      author_first_name: ['John'],
      author_last_name: ['Doe'],
      college_ids: [1, 2]
    },
    invalid_params: {
      invalid_field: 'InvalidValue',
      author_first_name: [''],
      author_last_name: ['']
    },
    new_params: {
      location: 'New Gallery',
      date: '2021-10-16'
    }
  }
end
