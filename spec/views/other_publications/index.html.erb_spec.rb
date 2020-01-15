# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'other_publications/index', type: :view do
  before(:each) do
    assign(:other_publications, [
             OtherPublication.create!(
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
             ),
             OtherPublication.create!(
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
             )
           ])
  end

  it 'renders a list of other_publications' do
    render
    assert_select 'tr>td', text: 'Author First Name'.to_s, count: 2
    assert_select 'tr>td', text: 'Author Last Name'.to_s, count: 2
    assert_select 'tr>td', text: '[1]'.to_s, count: 2
    assert_select 'tr>td', text: 'Uc Department'.to_s, count: 2
    assert_select 'tr>td', text: 'Work Title'.to_s, count: 2
    assert_select 'tr>td', text: 'Other Title'.to_s, count: 2
    assert_select 'tr>td', text: 'Volume'.to_s, count: 2
    assert_select 'tr>td', text: 'Issue'.to_s, count: 2
    assert_select 'tr>td', text: 'Page Numbers'.to_s, count: 2
    assert_select 'tr>td', text: 'Publisher'.to_s, count: 2
    assert_select 'tr>td', text: 'City'.to_s, count: 2
    assert_select 'tr>td', text: 'Publication Date'.to_s, count: 2
    assert_select 'tr>td', text: 'Url'.to_s, count: 2
    assert_select 'tr>td', text: 'Doi'.to_s, count: 2
    assert_select 'tr>td', text: 'Submitter'.to_s, count: 2
  end
end
