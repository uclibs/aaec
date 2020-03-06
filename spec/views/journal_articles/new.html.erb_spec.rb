# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'journal_articles/new', type: :view do
  before(:each) do
    @journal_article = FactoryBot.build(:journal_article)
  end

  it 'renders new journal_article form' do
    render

    assert_select 'form[action=?][method=?]', journal_articles_path, 'post' do
      assert_select 'input[name=?]', 'journal_article[author_first_name][]'

      assert_select 'input[name=?]', 'journal_article[author_last_name][]'

      assert_select 'input[name=?]', 'journal_article[college_ids][]'

      assert_select 'input[name=?]', 'journal_article[uc_department]'

      assert_select 'input[name=?]', 'journal_article[work_title]'

      assert_select 'input[name=?]', 'journal_article[other_title]'

      assert_select 'input[name=?]', 'journal_article[volume]'

      assert_select 'input[name=?]', 'journal_article[issue]'

      assert_select 'input[name=?]', 'journal_article[page_numbers]'

      assert_select 'input[name=?]', 'journal_article[publisher]'

      assert_select 'input[name=?]', 'journal_article[city]'

      assert_select 'input[name=?]', 'journal_article[publication_date]'

      assert_select 'input[name=?]', 'journal_article[url]'

      assert_select 'input[name=?]', 'journal_article[doi]'

      assert_select 'input[name=?]', 'journal_article[submitter_id]'
    end
  end
end
