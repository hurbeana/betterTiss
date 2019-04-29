class PeopleController < ApplicationController
  def show
    resp = HTTParty.get("https://tiss.tuwien.ac.at/api/person/v21/id/" + params[:id]).parsed_response
    doc = Nokogiri::XML(resp).remove_namespaces!
    doc.at_xpath('//person')
    debugger
  end

  def search
    @people = Person.search(params[:query]) if params[:query]
  end

  def favorite
    type = params[:type]
    @person = Person.find(params[:id])
    if type == 'favorite'
      current_user.people << @person
      redirect_to :back, notice: "You favorited #{@person.name}"

    elsif type == 'unfavorite'
      current_user.people.delete(@person)
      redirect_to :back, notice: "Unfavorited #{@person.name}"

    else
      # Type missing, nothing happens
      redirect_to :back, notice: 'Nothing happened.'
    end
  end
end