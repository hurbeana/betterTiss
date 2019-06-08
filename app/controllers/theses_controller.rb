##
# A controller for theses.
# Contains methods for paths: favorite, show and search
class ThesesController < ApplicationController
  include Favoritable

  ##
  # Search the TISS REST API for the query
  def search
    begin
      @theses = Thesis.search(params[:query]) if params[:query]
    rescue Searchable::SearchError => msg
      flash.now[:error] = msg
    rescue Searchable::NoSearchResults => msg
      flash.now[:notice] = msg
    end
  end

  ##
  # Show the given thesis with the given tiss_id
  def show
    @thesis = Thesis.load params[:id]
  end
end
