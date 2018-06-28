class TournamentsController < ApplicationController
  include YearlyController

  # Callbacks, in order
  load_resource
  add_filter_to_set_resource_year
  authorize_resource
  add_filter_restricting_resources_to_year_in_route

  # Actions
  def index
    @tournaments = @tournaments.yr(@year).order('lower(name)')
    @import = Tournament::Import.new
  end

  def create
    @tournament.year = @year.year
    if @tournament.save
      redirect_to tournament_path(@tournament), :notice => 'Tournament created.'
    else
      render :action => "new"
    end
  end

  def edit
    @import = Tournament::Import.new
  end

  def import
    @import = Tournament::Import.new tournament_import_params
    if @import.save
      redirect_to tournament_path(@tournament), notice: "Imported Tournament Data"
    else
      render action: :edit, notice: "There were errors with the XML file"
    end
  end
  
  

  def update
    if @tournament.update_attributes!(tournament_params)
      redirect_to tournament_path(@tournament), :notice => 'Tournament updated.'
    else
      render :action => "edit"
    end
  end

  def destroy
    @tournament.destroy
    redirect_to tournaments_url
  end

  private

  def tournament_import_params
    params.require(:tournament_import).permit(:file, :id, :year)
  end
  
  def tournament_params
    params.require(:tournament).permit(:description, :directors, :eligible,
      :location, :name, :openness, :show_in_nav_menu)
  end
end
