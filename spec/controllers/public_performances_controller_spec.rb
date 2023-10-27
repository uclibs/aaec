# frozen_string_literal: true

require 'rails_helper'
require 'support/shared_publication_examples/main_shared_examples'

RSpec.describe PublicPerformancesController, type: :controller do
  it_behaves_like 'a standard publication controller', {
    model_name: :public_performance,
    valid_params: {
      uc_department: 'Performing Arts',
      other_college: 'Other College',
      work_title: 'The Performance',
      other_title: 'The Other Performance',
      location: 'Performance Venue',
      time: '7:00 PM',
      date: '2021-11-05',
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
      location: 'New Venue',
      time: '8:00 PM',
      date: '2022-11-05'
    }
  }
end
