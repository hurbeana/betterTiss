class PeopleController < ApplicationController
  include Favoritable

  def show
    @person = Person.load(params[:id])
  end

  def search
    @people = Person.search(params[:query]) if params[:query]
  end
end