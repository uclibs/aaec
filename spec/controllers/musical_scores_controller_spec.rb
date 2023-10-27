# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MusicalScoresController, type: :controller do
  it_behaves_like 'a standard publication controller', {
    model_name: :musical_score,
    valid_params: {
      uc_department: 'Music Department',
      other_college: 'Other College',
      work_title: 'Musical Work Title',
      other_title: 'Other Title',
      publisher: 'Music Publisher',
      city: 'Music City',
      publication_date: '2021-11-02',
      url: 'https://example.com',
      doi: 'doi:example',
      submitter_id: 1,
      author_first_name: ['John'],
      author_last_name: ['Smith'],
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
      publication_date: '2022-11-02'
    }
  }
end
