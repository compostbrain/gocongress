class HomeController < ApplicationController
  rescue_from  ActionView::MissingTemplate, :with => :missing_template

  def index
    @bodyClassList = "homepage"
    @slides = SlideSet.new(@year.year).slides_as_arrays
    @contents = Content.yr(@year).homepage.unexpired.newest_first
    @years = 2011..LATEST_YEAR
    @logo_file = logo_file(@year)
  end

  def access_denied
  end

  def kaboom
    raise "Intentional error to test runtime exception notification"
  end

protected

  def page_title
    human_action_name
  end

  private

  def logo_file year
    if year.to_i == 2014
      '2014-logo.png'
    elsif year.to_i == 2013
      '2013.jpg'
    else
      "#{@year.year}.png"
    end
  end

  private

  # Image spiders are requesting / with
  # HTTP_ACCEPT = image/jpeg,image/gif,image/bmp,image/png
  # which causes a MissingTemplate error.
  #
  # It's an open issue: "in certain circumstances, Rails does not recognize
  # an unacceptable request before attempting template lookup."
  # https://github.com/rails/rails/issues/4127
  #
  def missing_template
    render :nothing => true, :status => 406
  end
end
