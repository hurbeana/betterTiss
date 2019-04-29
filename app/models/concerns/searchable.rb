
module Searchable
    extend ActiveSupport::Concern

  module ClassMethods
      def search(query)
        return if query.nil?

        response = HTTParty.get(self.tiss_search_link + CGI.escape(query)).parsed_response['results']
        result = Array.new
        response.each do |p|
          obj = self.new(tiss_id: p['id'])
          obj.fill p
          obj.save
          result << obj
        end
        result
      end
  end
end