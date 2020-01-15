# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'books/index', type: :view do
  before(:each) do
    assign(:books, [
             Book.create!(
               author_first_name: 'Author First Name',
               author_last_name: 'Author Last Name',
               college_ids: [1],
               uc_department: 'Uc Department',
               work_title: 'Work Title',
               other_title: 'Other Title',
               publisher: 'Publisher',
               city: 'City',
               publication_date: 'Publication Date',
               url: 'Url',
               doi: 'Doi',
               submitter_id: 'Submitter'
             ),
             Book.create!(
               author_first_name: 'Author First Name',
               author_last_name: 'Author Last Name',
               college_ids: [1],
               uc_department: 'Uc Department',
               work_title: 'Work Title',
               other_title: 'Other Title',
               publisher: 'Publisher',
               city: 'City',
               publication_date: 'Publication Date',
               url: 'Url',
               doi: 'Doi',
               submitter_id: 'Submitter'
             )
           ])
  end

  it 'renders a list of books' do
    render
    assert_select 'tr>td', text: 'Author First Name'.to_s, count: 2
    assert_select 'tr>td', text: 'Author Last Name'.to_s, count: 2
    assert_select 'tr>td', text: '[1]'.to_s, count: 2
    assert_select 'tr>td', text: 'Uc Department'.to_s, count: 2
    assert_select 'tr>td', text: 'Work Title'.to_s, count: 2
    assert_select 'tr>td', text: 'Other Title'.to_s, count: 2
    assert_select 'tr>td', text: 'Publisher'.to_s, count: 2
    assert_select 'tr>td', text: 'City'.to_s, count: 2
    assert_select 'tr>td', text: 'Publication Date'.to_s, count: 2
    assert_select 'tr>td', text: 'Url'.to_s, count: 2
    assert_select 'tr>td', text: 'Doi'.to_s, count: 2
    assert_select 'tr>td', text: 'Submitter'.to_s, count: 2
  end
end
