# frozen_string_literal: true

class DigitalProjectsController < PublicationsController
  include UserAuthentication

  # Never trust parameters from the scary internet, only allow the white list through.
  def allowed_params
    params.require(:digital_project).permit(:uc_department, :other_college, :work_title, :other_title, :name_of_site, :name_of_affiliated_organization, :publication_date, :version, :url, :doi, :submitter_id, author_first_name: [], author_last_name: [], college_ids: [])
  end
  helper_method :allowed_params
end
