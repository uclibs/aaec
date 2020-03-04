# frozen_string_literal: true

class FilmsController < PublicationsController
  # Never trust parameters from the scary internet, only allow the white list through.
  def allowed_params
    params.require(:film).permit(:uc_department, :work_title, :other_title, :director, :release_year, :submitter_id, author_first_name: [], author_last_name: [], college_ids: [])
  end
  helper_method :allowed_params
end
