class CoursesController < ApplicationController
  include Favoritable

  def show
    @course = Course.load params[:id]
  end

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
