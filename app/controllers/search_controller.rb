# frozen_string_literal: true

require 'httparty'
# A controller for searches on TISS
class SearchController < ApplicationController
  def people
    @response = execute_search(Person.tiss_search_link)
  end

  def courses
    execute_search(tiss_course_search_link)
  end
end
