# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DigitalProjectsController, type: :controller do
  it_behaves_like 'a standard publication controller', {
    model_name: :digital_project,
    valid_params: {
      uc_department: 'Department',
      other_college: 'Other College',
      work_title: 'Work Title',
      other_title: 'Other Title',
      name_of_site: 'Site Name',
      name_of_affiliated_organization: 'Organization Name',
      publication_date: '2021-10-13',
      version: '1.0',
      url: 'https://example.com',
      doi: 'doi:example',
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
      name_of_site: 'New Site Name',
      name_of_affiliated_organization: 'New Organization Name',
      publication_date: '2021-10-14',
      version: '2.0'
    }
  }
end
