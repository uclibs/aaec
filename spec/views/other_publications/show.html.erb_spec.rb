# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'other_publications/show', type: :view do
  before(:each) do
    @other_publication = assign(:other_publication, OtherPublication.create!(
                                                      author_first_name: 'Author First Name',
                                                      author_last_name: 'Author Last Name',
                                                      college_ids: [1],
                                                      uc_department: 'Uc Department',
                                                      work_title: 'Work Title',
                                                      other_title: 'Other Title',
                                                      volume: 'Volume',
                                                      issue: 'Issue',
                                                      page_numbers: 'Page Numbers',
                                                      publisher: 'Publisher',
                                                      city: 'City',
                                                      publication_date: 'Publication Date',
                                                      url: 'Url',
                                                      doi: 'Doi',
                                                      submitter_id: 'Submitter'
                                                    ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Author First Name/)
    expect(rendered).to match(/Author Last Name/)
    expect(rendered).to match(/[1]/)
    expect(rendered).to match(/Uc Department/)
    expect(rendered).to match(/Work Title/)
    expect(rendered).to match(/Other Title/)
    expect(rendered).to match(/Volume/)
    expect(rendered).to match(/Issue/)
    expect(rendered).to match(/Page Numbers/)
    expect(rendered).to match(/Publisher/)
    expect(rendered).to match(/City/)
    expect(rendered).to match(/Publication Date/)
    expect(rendered).to match(/Url/)
    expect(rendered).to match(/Doi/)
    expect(rendered).to match(/Submitter/)
  end
end