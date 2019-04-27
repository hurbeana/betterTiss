
module Searchable
    extend ActiveSupport::Concern

  module ClassMethods
      def search(query)
        return if query.nil?

        response = HTTParty.get(self.tiss_search_link + CGI.escape(query)).parsed_response['results']
        response&.map! do |p|
          self.new p
        end
      end
  end
end