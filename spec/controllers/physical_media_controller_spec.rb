# frozen_string_literal: true

require 'rails_helper'
require 'support/shared_publication_examples/main_shared_examples'

RSpec.describe PhysicalMediaController, type: :controller do
  it_behaves_like 'a standard publication controller', {
    model_name: :physical_medium,
    valid_params: {
      uc_department: 'Physical Media Department',
      other_college: 'Other College',
      work_title: 'Physical Work',
      other_title: 'Other Title',
      publisher: 'Physical Media Publisher',
      city: 'Physical Media City',
      publication_date: '2021-11-04',
      url: 'https://example.com',
      doi: 'doi:example',
      submitter_id: 1,
      author_first_name: ['Jane'],
      author_last_name: ['Doe'],
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
      publication_date: '2022-11-04'
    }
  }
end
