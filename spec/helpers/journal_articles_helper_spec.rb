# frozen_string_literal: true

require 'rails_helper'

RSpec.describe JournalArticlesHelper, type: :helper do
  let(:journal_article) { FactoryBot.create(:journal_article) }

  describe '#find_journal_articles(id)' do
    it 'returns the requested journal articles in an array' do
      expect(helper.find_journal_articles(journal_article.submitter_id)).to eq Array.wrap(journal_article)
    end
  end
end
