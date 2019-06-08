##
# A controller for projects.
# Contains methods for paths: favorite, show and search
class ProjectsController < ApplicationController
  include Favoritable

  ##
  # Search the TISS REST API for with the query
  def search
    begin
      @projects = Project.search(params[:query]) if params[:query]
    rescue Searchable::SearchError => msg
      flash.now[:error] = msg
    rescue Searchable::NoSearchResults => msg
      flash.now[:notice] = msg
    end
  end

  ##
  # Show the given project with given tiss_id
  def show
    @project = Project.load params[:id]
  end
end
