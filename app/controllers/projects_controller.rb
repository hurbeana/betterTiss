class ProjectsController < ApplicationController

  def search
    begin
      @projects = Project.search(params[:query]) if params[:query]
    rescue Searchable::SearchError => msg
      flash.now[:error] = msg
    rescue Searchable::NoSearchResults => msg
      flash.now[:notice] = msg
    end
  end

  def show
    @project = Project.load params[:id]
  end
end
