# frozen_string_literal: true

require 'httparty'
class SearchController < ApplicationController
  def people
    url = 'https://tiss.tuwien.ac.at/api/person/v21/psuche?q='
    execute_search(url)
  end

  def courses
    url = 'https://tiss.tuwien.ac.at/api/search/course/v1.0/quickSearch?searchterm='
    execute_search(url)
  end

  private

  def execute_search(url)
    @response = HTTParty.get(url + CGI.escape(params[:query])) unless params[:query].nil?
  end
end
