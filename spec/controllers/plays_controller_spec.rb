# frozen_string_literal: true

require 'rails_helper'
require 'support/shared_publication_examples/main_shared_examples'

RSpec.describe PlaysController, type: :controller do
  it_behaves_like 'a standard publication controller', {
    model_name: :play,
    valid_params: {
      uc_department: 'Theater Department',
      other_college: 'Other College',
      work_title: 'The Play',
      other_title: 'The Other Play',
      publisher: 'Play Publisher',
      city: 'Play City',
      publication_date: '2021-11-05',
      url: 'https://example.com',
      doi: 'doi:example',
      submitter_id: 1,
      author_first_name: ['William'],
      author_last_name: ['Shakespeare'],
      college_ids: [1, 2]
    },
    invalid_params: {
      invalid_field: 'Invalid',
      author_first_name: [''],
      author_last_name: ['']
    },
    new_params: {
      publisher: 'New Publisher',
      city: 'New City',
      publication_date: '2022-11-05'
    }
  }
end
