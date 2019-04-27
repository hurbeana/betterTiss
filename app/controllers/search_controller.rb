# frozen_string_literal: true

require 'httparty'
# A controller for searches on TISS
class SearchController < ApplicationController
  def people
    @response = execute_search(Person.tiss_search_link)
    @response&.map! do |p|
      Person.new p
    end
  end

  def courses
    execute_search(tiss_course_search_link)
  end

  private

  def execute_search(url)
    return if params[:query].nil?

    HTTParty.get(url + CGI.escape(params[:query])).parsed_response['results']
  end
end
