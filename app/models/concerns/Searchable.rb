##
# A module that can be mixed in into a model to make it searchable via the TISS
# REST API
module Searchable
  extend ActiveSupport::Concern

  ##
  # This Error is to be triggered when the query is empty or the REST API
  # responds with an error
  class SearchError < StandardError
  end

  ##
  # This Error is to be triggered when no results have been found
  class NoSearchResults < StandardError
  end

  ##
  # ClassMethods that are being mixed in with this module
  module ClassMethods

    ##
    # Needs to be overridden.
    # Returns the http link of the TISS Search API that is being used by the
    # search function.
    # @return [String] The http link to the search API from TISS
    def tiss_search_link
      raise NotImplementedError
    end

    ##
    # Needs to be overridden.
    # Returns the tiss_id given any hash which contains the TISS ID in any place
    # @return [String] The TISS ID of the object that is represented by the hash
    def get_id(p)
      raise NotImplementedError
    end

    ##
    # Searches tiss with the given query for objects that have the mixin
    # MassAssignable
    # @return [Array<ActiveRecord>] The results that were found
    def search(query)
      return if query.nil?

      if query == ''
        raise SearchError.new 'Please enter a search query'
      end

      response = HTTParty.get(tiss_search_link + CGI.escape(query)).parsed_response
      if response.key?('error_message')
        raise SearchError.new response['error_message']
      end

      response = response['results']

      result = Array[]
      response.each do |p|
        id = get_id(p)
        obj = find_by(tiss_id: id)
        obj = new(tiss_id: id) if obj.nil?
        obj.assign_hash p
        result << obj
      end

      if result.empty?
        raise NoSearchResults.new 'No results found'
      else
        result
      end

    end
  end
end
