class PeopleController < ApplicationController
  include Favoritable

  def show
    resp = HTTParty.get('https://tiss.tuwien.ac.at/api/person/v21/id/' + params[:id])
                   .parsed_response['tuvienna']['person']
    @person = Person.new
    @person.fillhash resp
  end

  def search
    @people = Person.search(params[:query]) if params[:query]
  end
end