##
# A controller for courses.
# Contains methods for paths: favorite, show and search
class CoursesController < ApplicationController
  include Favoritable

  ##
  # Show the given course with given tiss_id
  def show
    @course = Course.load params[:id] # load object from TISS REST API
  end

  ##
  # Search the TISS REST API for with the query
  def search
    begin
      @courses = Course.search(params[:query]) if params[:query]
    rescue Searchable::SearchError => msg
      flash.now[:error] = msg
    rescue Searchable::NoSearchResults => msg
      flash.now[:notice] = msg
    end
  end
end
