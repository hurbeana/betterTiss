class CoursesController < ApplicationController
  include Favoritable

  def show
    @course = Course.load params[:id]
  end

  def search
    @courses = Course.search(params[:query]) if params[:query]
  end
end
