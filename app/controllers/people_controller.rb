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
    end
  end
end