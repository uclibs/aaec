# frozen_string_literal: true

class CreateJoinTableCollegeJournalArticle < ActiveRecord::Migration[5.2]
  def change
    create_join_table :colleges, :journal_articles do |t|
      # t.index [:college_id, :journal_article_id]
      # t.index [:journal_article_id, :college_id]
    end
  end
end
