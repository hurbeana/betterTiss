##
# A controller for people.
# Contains methods for paths: favorite, show and search
class PeopleController < ApplicationController
  include Favoritable

  ##
  # Show the given person with the given tiss_id
  def show
    @person = Person.load(params[:id]) # load object from TISS REST API
  end

  ##
  # Search the TISS REST API for the query
  def search
    begin
      @people = Person.search(params[:query]) if params[:query]
    rescue Searchable::SearchError => msg
      flash.now[:error] = msg
    rescue Searchable::NoSearchResults => msg
      flash.now[:notice] = msg
    end
  end
end