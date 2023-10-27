# frozen_string_literal: true

require 'rails_helper'
require 'support/shared_publication_examples/main_shared_examples'

RSpec.describe FilmsController, type: :controller do
  it_behaves_like 'a standard publication controller', {
    model_name: :film,
    valid_params: {
      uc_department: 'Film Department',
      other_college: 'Other Film College',
      work_title: 'Sample Film',
      other_title: 'Alternative Title',
      producer: 'Sample Producer',
      director: 'Sample Director',
      release_year: '2021',
      submitter_id: 1,
      author_first_name: ['John'],
      author_last_name: ['Doe'],
      college_ids: [1, 2]
    },
    invalid_params: {
      invalid_field: 'Invalid',
      author_first_name: [''],
      author_last_name: ['']
    },
    new_params: {
      producer: 'New Producer',
      director: 'New Director',
      release_year: '2022'
    }
  }
end
