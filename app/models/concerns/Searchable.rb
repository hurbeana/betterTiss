module Searchable
  extend ActiveSupport::Concern

  class SearchError < StandardError
  end

  class NoSearchResults < StandardError
  end

  module ClassMethods
    def tiss_search_link
      raise NotImplementedError
    end

    def get_id(p)
      raise NotImplementedError
    end

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
