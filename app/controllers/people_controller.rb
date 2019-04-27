class PeopleController < ApplicationController
  def search
    @people = Person.search(params[:query]) if params[:query]
  end

  def favorite
    type = params[:type]
    if type == 'favorite'
      current_user.people << @person
      redirect_to :back, notice: "You favorited #{@recipe.name}"

    elsif type == 'unfavorite'
      current_user.people.delete(@person)
      redirect_to :back, notice: "Unfavorited #{@recipe.name}"

    else
      # Type missing, nothing happens
      redirect_to :back, notice: 'Nothing happened.'
    end
  end
end