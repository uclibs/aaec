# frozen_string_literal: true

class JournalArticlesController < PublicationsController
  include UserAuthentication
  include CacheHeaderControl

  # Never trust parameters from the scary internet, only allow the white list through.
  def allowed_params
    params.require(:journal_article).permit(:uc_department, :other_college, :work_title, :other_title, :volume, :issue, :page_numbers, :publication_date, :url, :doi, :submitter_id, author_first_name: [], author_last_name: [], college_ids: [])
  end
  helper_method :allowed_params
end
