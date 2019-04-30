module RESTObject
  include MassAssignable
  extend ActiveSupport::Concern

  included do
    after_initialize :load
  end

  def assign_hash(hash)
    super hash
    hash['tiss_id'] = self.class.get_id(hash)
    create_if_exists hash, 'id', name: :tiss_id
  end

  def load
    res = self.class.filter_response(HTTParty.get(self.class.rest_resource + tiss_id).parsed_response)
    assign_hash res
  end

  module ClassMethods
    def load(tiss_id)
      obj = find_by(tiss_id: tiss_id)
      obj = new(tiss_id: tiss_id) if obj.nil?
      resp = filter_response(HTTParty.get(rest_resource + tiss_id).parsed_response)
      obj.assign_hash resp
      obj
    end
  end
end