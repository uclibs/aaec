# frozen_string_literal: true

class JournalArticlesController < PublicationsController
  # Never trust parameters from the scary internet, only allow the white list through.
  def allowed_params
    params.require(:journal_article).permit(:uc_department, :work_title, :other_title, :volume, :issue, :page_numbers, :publisher, :city, :publication_date, :url, :doi, :submitter_id, author_first_name: [], author_last_name: [], college_ids: [])
  end
  helper_method :allowed_params
end
