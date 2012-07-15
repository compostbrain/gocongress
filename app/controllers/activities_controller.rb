class ActivitiesController < ApplicationController
  include YearlyController

  # Callbacks, in order
  load_resource
  add_filter_to_set_resource_year
  authorize_resource
  add_filter_restricting_resources_to_year_in_route

  # GET /activities/1
  def show
  end

  # GET /activities/new
  def new
  end

  # GET /activities/1/edit
  def edit
  end

  # POST /activities
  def create
    @activity.year = @year.year
    if @activity.save
      redirect_to @activity, :notice => "#{Activity.model_name.human} created"
    else
      render :action => "new"
    end
  end

  # PUT /activities/1
  def update
    if @activity.update_attributes(params[:activity])
      redirect_to @activity, :notice => "#{Activity.model_name.human} updated"
    else
      render :action => "edit"
    end
  end

  # DELETE /activities/1
  def destroy
    @activity.destroy
    redirect_to activity_category_url @activity.activity_category
  end

  def activity_category_options
    ActivityCategory.yr(@year).all.map {|c| [ c.name, c.id ] }
  end
  helper_method :activity_category_options

end
