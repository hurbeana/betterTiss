class ThesesController < ApplicationController

  def search
    begin
      @theses = Thesis.search(params[:query]) if params[:query]
    rescue Searchable::SearchError => msg
      flash.now[:error] = msg
    rescue Searchable::NoSearchResults => msg
      flash.now[:notice] = msg
    end
  end

  def show
    @thesis = Thesis.load params[:id]
  end
end
