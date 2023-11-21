# frozen_string_literal: true

class AdminController < ApplicationController
  include AdminOnlyAccess

  skip_before_action :require_authenticated_user, only: %i[login validate]
  skip_before_action :check_date
  skip_before_action :check_admin, only: %i[login validate]

  ALLOWED_CONTROLLERS_TO_MODELS = {
    'artworks' => Artwork,
    'books' => Book,
    'book_chapters' => BookChapter,
    'digital_projects' => DigitalProject,
    'editings' => Editing,
    'films' => Film,
    'journal_articles' => JournalArticle,
    'musical_scores' => MusicalScore,
    'photographies' => Photography,
    'physical_media' => PhysicalMedium,
    'plays' => Play,
    'public_performances' => PublicPerformance,
    'submitters' => Submitter,
    'other_publications' => OtherPublication
  }.freeze

  def login; end

  def validate
    if check_credentials(params[:username], params[:password])
      reset_session
      session[:admin] = true
      redirect_to publications_path
    else
      flash.keep[:danger] = 'Invalid Credentails'
      redirect_to manage_path
    end
  end

  # Generates a CSV file for a given model. This method is restricted
  # to admin users through the AdminOnlyAccess concern.
  def csv
    if params[:id].nil? && allowed_model
      begin
        @instance_variable = allowed_model.all
        respond_to do |format|
          format.html { redirect_to publications_path }
          format.csv { send_data @instance_variable.to_csv }
        end
      rescue StandardError => e
        logger.error "CSV generation failed: #{e}"
        flash.keep[:danger] = 'Something went wrong while generating the CSV.'
        redirect_to publications_path
      end
    else
      redirect_to publications_path
    end
  end

  # Generates a citations report. This method is restricted to admin
  # users through the AdminOnlyAccess concern.
  def citations
    all_publications = fetch_all_records
    @college_departments_grouped = []

    College.find_each do |college|
      publications_in_college = all_publications.select do |publication|
        publication.respond_to?(:college_ids) && publication.college_ids.include?(college.id)
      end
      grouped_by_department = publications_in_college.group_by(&:uc_department)
      @college_departments_grouped << [college.id, grouped_by_department]
    end
  end

  def toggle_links
    session[:links] = session[:links] == false
    redirect_to citations_path
  end

  private

  def check_credentials(username, password)
    username == ENV['ADMIN_USERNAME'] && password == ENV['ADMIN_PASSWORD']
  end

  def allowed_model
    ALLOWED_CONTROLLERS_TO_MODELS[params[:controller_name]]
  end

  def fetch_all_records
    all_records = []
    ALLOWED_CONTROLLERS_TO_MODELS.each_value do |model|
      all_records += model.all
    end
    all_records
  end
end
