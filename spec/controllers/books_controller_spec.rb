# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  it_behaves_like 'a standard publication controller', {
    model_name: :book,
    valid_params: {
      uc_department: 'Department',
      work_title: 'Work Title',
      other_title: 'Other Title',
      publisher: 'Publisher',
      city: 'City',
      publication_date: '2021-10-13',
      url: 'https://example.com',
      doi: 'doi:example',
      other_college: 'Other College',
      submitter_id: 1,
      author_first_name: ['First'],
      author_last_name: ['Last'],
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
      publication_date: '2021-10-14'
    }
  }
end
