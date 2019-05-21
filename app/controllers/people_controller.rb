class PeopleController < ApplicationController
  include Favoritable

  def show
    @person = Person.load(params[:id])
  end

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