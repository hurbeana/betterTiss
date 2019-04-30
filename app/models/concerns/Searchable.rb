module Searchable
  extend ActiveSupport::Concern

  module ClassMethods
    def search(query)
      return if query.nil?

      response = HTTParty.get(tiss_search_link + CGI.escape(query)).parsed_response['results']
      result = Array.new
      response.each do |p|
        obj = new(tiss_id: p['id'])
        obj.fillarray p
        result << obj
      end
      result
    end
  end
end
