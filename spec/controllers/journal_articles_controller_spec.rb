# frozen_string_literal: true

require 'rails_helper'

RSpec.describe JournalArticlesController, type: :controller do
  it_behaves_like 'a standard publication controller', {
    model_name: :journal_article,
    valid_params: {
      uc_department: 'Journal Department',
      other_college: 'Other College',
      work_title: 'Journal Work Title',
      other_title: 'Other Title',
      volume: 'Volume 1',
      issue: 'Issue 1',
      page_numbers: '1-10',
      publication_date: '2021-11-01',
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
      volume: 'Volume 2',
      issue: 'Issue 2',
      publication_date: '2022-11-01'
    }
  }
end
