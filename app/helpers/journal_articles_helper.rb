# frozen_string_literal: true

module JournalArticlesHelper
  def find_journal_articles(id)
    Array.wrap(JournalArticle.where(submitter_id: id))
  end
end
