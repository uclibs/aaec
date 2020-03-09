# frozen_string_literal: true

class RemovePublisherCityFromJournalArticle < ActiveRecord::Migration[5.2]
  def change
    remove_column :journal_articles, :publisher, :string
    remove_column :journal_articles, :city, :string
  end
end
