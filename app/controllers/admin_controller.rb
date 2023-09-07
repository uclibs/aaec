# frozen_string_literal: true

class AdminController < ApplicationController
  skip_before_action :check_date

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
      session[:admin] = true
      redirect_to publications_path
    else
      redirect_to manage_path, notice: 'Invalid Credentails'
    end
  end

  def csv
    if session[:admin] && params[:id].nil? && allowed_model
      begin
        @instance_variable = allowed_model.all
        respond_to do |format|
          format.html { redirect_to publications_path }
          format.csv { send_data @instance_variable.to_csv }
        end
      rescue StandardError => e
        logger.error "CSV generation failed: #{e}"
        redirect_to publications_path, notice: 'Something went wrong while generating the CSV.'
      end
    else
      redirect_to publications_path
    end
  end

  def citations
    if session[:admin]
      all = (Artwork.all + Book.all + BookChapter.all + DigitalProject.all + Editing.all + Film.all + JournalArticle.all + MusicalScore.all + Photography.all + PhysicalMedium.all + Play.all + PublicPerformance.all + OtherPublication.all)
      @college_array = []
      (1..College.count).each do |i|
        @college_array << [i, all.select { |p| p.college_ids.include? i }.group_by(&:uc_department)]
      end
    else
      redirect_to publications_path
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
end
