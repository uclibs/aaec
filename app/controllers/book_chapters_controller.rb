# frozen_string_literal: true

class BookChaptersController < PublicationsController
  # Never trust parameters from the scary internet, only allow the white list through.
  def allowed_params
    params.require(:book_chapter).permit(:uc_department, :other_college, :work_title, :other_title, :page_numbers, :publisher, :city, :publication_date, :url, :doi, :submitter_id, author_first_name: [], author_last_name: [], college_ids: [])
  end
  helper_method :allowed_params
end
