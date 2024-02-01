# frozen_string_literal: true

# == Schema Information
#
# Controller: PublicationsController
#
# Overview:
# The PublicationsController handles the CRUD operations for various types of
# publications like Artwork, Book, BookChapter, and so on. It is designed to
# handle submissions from both admin and regular users.
#
# Responsibilities:
# - Filtering requests based on the logged-in user type (Admin or regular user)
# - Managing CRUD operations for multiple publication types
# - Sending notifications via PublicationMailer upon successful publication submission
# - Redirecting based on various conditions such as user session and max submissions
#
# Special Behaviors:
# - Utilizes dynamic setting of instance variables and object types
# - Makes extensive use of helpers for finding records
#
# Filters:
# - set_object: Sets the object based on the controller name and params[:id].
# - signed_in: Checks if the user is signed in before granting access to certain actions.
# - check_max_submissions: Checks if the maximum submission limit is reached for a given user.
#

class PublicationsController < ApplicationController
  include SubmitterOwnershipGuard

  before_action :set_object, only: %i[show edit update destroy]
  before_action :signed_in, only: %i[index show edit update destroy]
  before_action :check_max_submissions, only: %i[new]

  def index
    redirect_to publications_path unless request.path.include? publications_path
    if session[:admin] && params[:id].nil?
      @pagy_submitters, @submitters = pagy(Submitter.all, page_param: :page_submitters)
      @pagy_artworks, @artworks = pagy(Artwork.all, page_param: :page_artworks)
      @pagy_books, @books = pagy(Book.all, page_param: :page_books)
      @pagy_book_chapters, @book_chapters = pagy(BookChapter.all, page_param: :page_book_chapters)
      @pagy_digital_projects, @digital_projects = pagy(DigitalProject.all, page_param: :page_digital_projectss)
      @pagy_editings, @editings = pagy(Editing.all, page_param: :page_editings)
      @pagy_films, @films = pagy(Film.all, page_param: :page_films)
      @pagy_journal_articles, @journal_articles = pagy(JournalArticle.all, page_param: :page_journal_articles)
      @pagy_musical_scores, @musical_scores = pagy(MusicalScore.all, page_param: :page_musical_scores)
      @pagy_photographies, @photographies = pagy(Photography.all, page_param: :page_photographies)
      @pagy_physical_media, @physical_media = pagy(PhysicalMedium.all, page_param: :page_physical_media)
      @pagy_plays, @plays = pagy(Play.all, page_param: :page_plays)
      @pagy_public_performances, @public_performances = pagy(PublicPerformance.all, page_param: :page_public_performances)
      @pagy_other_publications, @other_publications = pagy(OtherPublication.all, page_param: :page_other_publications)
      @submitter_count = Submitter.all.count
      @artwork_count = Artwork.all.count
      @book_count = Book.all.count
      @book_chapter_count = BookChapter.all.count
      @digital_project_count = DigitalProject.all.count
      @editing_count = Editing.all.count
      @film_count = Film.all.count
      @journal_article_count = JournalArticle.all.count
      @musical_score_count = MusicalScore.all.count
      @photography_count = Photography.all.count
      @physical_medium_count = PhysicalMedium.all.count
      @play_count = Play.all.count
      @public_performance_count = PublicPerformance.all.count
      @other_publication_count = OtherPublication.all.count
    elsif session[:admin] && params[:id]
      @submitter = helpers.find_submitter(params[:id])
      @artworks = helpers.find_artworks(params[:id])
      @books = helpers.find_books(params[:id])
      @book_chapters = helpers.find_book_chapters(params[:id])
      @digital_projects = helpers.find_digital_projects(params[:id])
      @editings = helpers.find_editings(params[:id])
      @films = helpers.find_films(params[:id])
      @journal_articles = helpers.find_journal_articles(params[:id])
      @musical_scores = helpers.find_musical_scores(params[:id])
      @photographies = helpers.find_photographies(params[:id])
      @physical_media = helpers.find_physical_media(params[:id])
      @plays = helpers.find_plays(params[:id])
      @public_performances = helpers.find_public_performances(params[:id])
      @other_publications = helpers.find_other_publications(params[:id])
      @artwork_count = helpers.find_artworks(params[:id]).count
      @book_count = helpers.find_books(params[:id]).count
      @book_chapter_count = helpers.find_book_chapters(params[:id]).count
      @digital_project_count = helpers.find_digital_projects(params[:id]).count
      @editing_count = helpers.find_editings(params[:id]).count
      @film_count = helpers.find_films(params[:id]).count
      @journal_article_count = helpers.find_journal_articles(params[:id]).count
      @musical_score_count = helpers.find_musical_scores(params[:id]).count
      @photography_count = helpers.find_photographies(params[:id]).count
      @physical_medium_count = helpers.find_physical_media(params[:id]).count
      @play_count = helpers.find_plays(params[:id]).count
      @public_performance_count = helpers.find_public_performances(params[:id]).count
      @other_publication_count = helpers.find_other_publications(params[:id]).count
    else
      redirect_to publications_path if params[:id]
      @submitter = helpers.find_submitter(session[:submitter_id])
      @artworks = helpers.find_artworks(session[:submitter_id])
      @books = helpers.find_books(session[:submitter_id])
      @book_chapters = helpers.find_book_chapters(session[:submitter_id])
      @digital_projects = helpers.find_digital_projects(session[:submitter_id])
      @editings = helpers.find_editings(session[:submitter_id])
      @films = helpers.find_films(session[:submitter_id])
      @journal_articles = helpers.find_journal_articles(session[:submitter_id])
      @musical_scores = helpers.find_musical_scores(session[:submitter_id])
      @photographies = helpers.find_photographies(session[:submitter_id])
      @physical_media = helpers.find_physical_media(session[:submitter_id])
      @public_performances = helpers.find_public_performances(session[:submitter_id])
      @plays = helpers.find_plays(session[:submitter_id])
      @other_publications = helpers.find_other_publications(session[:submitter_id])
    end
  end

  def show
    @submitter = helpers.find_submitter(instance_variable_get("@#{controller_name.singularize}").id) if session[:admin]
  end

  def new
    instance_variable_set("@#{controller_name.singularize}", Object.const_get(controller_name.classify).new)
  end

  def edit; end

  def create
    instance_variable_set("@#{controller_name.singularize}", Object.const_get(controller_name.classify).new(allowed_params))
    instance_variable = instance_variable_get("@#{controller_name.singularize}")
    respond_to do |format|
      if instance_variable.save
        PublicationMailer.publication_submit(helpers.find_submitter(session[:submitter_id]), instance_variable).deliver_now
        flash.keep[:success] = "#{controller_name.classify} was successfully created."

        format.html { redirect_to publications_path }
        format.json { render :show, status: :created, location: instance_variable }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: instance_variable.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    instance_variable = instance_variable_get("@#{controller_name.singularize}")
    respond_to do |format|
      if instance_variable.update(allowed_params)
        flash.keep[:success] = "#{controller_name.classify} was successfully updated."
        format.html { redirect_to instance_variable }
        format.json { render :show, status: :created, location: instance_variable }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: instance_variable.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    instance_variable = instance_variable_get("@#{controller_name.singularize}")
    instance_variable.destroy
    respond_to do |format|
      flash.keep[:warning] = "#{controller_name.classify} was successfully destroyed."
      format.html { redirect_to publications_path }
      format.json { head :no_content }
    end
  end

  protected

  def set_object
    instance_variable_set("@#{controller_name.singularize}", Object.const_get(controller_name.classify).find_by(id: params[:id]))
  end

  def signed_in
    redirect_to root_path unless session[:admin] || session[:submitter_id]
  end

  def check_max_submissions
    redirect_to publications_path if Object.const_get(controller_name.classify).where(submitter_id: session[:submitter_id]).count > 2
  end
end
