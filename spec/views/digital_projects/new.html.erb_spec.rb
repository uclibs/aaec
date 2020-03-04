# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'digital_projects/new', type: :view do
  before(:each) do
    @digital_project = FactoryBot.build(:digital_project)
  end

  it 'renders new digital_project form' do
    render

    assert_select 'form[action=?][method=?]', digital_projects_path, 'post' do
      assert_select 'input[name=?]', 'digital_project[author_first_name][]'

      assert_select 'input[name=?]', 'digital_project[author_last_name][]'

      assert_select 'input[name=?]', 'digital_project[college_ids][]'

      assert_select 'input[name=?]', 'digital_project[uc_department]'

      assert_select 'input[name=?]', 'digital_project[work_title]'

      assert_select 'input[name=?]', 'digital_project[other_title]'

      assert_select 'input[name=?]', 'digital_project[name_of_site]'

      assert_select 'input[name=?]', 'digital_project[name_of_affiliated_organization]'

      assert_select 'input[name=?]', 'digital_project[publication_date]'

      assert_select 'input[name=?]', 'digital_project[version]'

      assert_select 'input[name=?]', 'digital_project[url]'

      assert_select 'input[name=?]', 'digital_project[doi]'

      assert_select 'input[name=?]', 'digital_project[submitter_id]'
    end
  end
end
