##
# This mixin turns a ActiveRecord into a Restresource that will load additional
# data based on a TISS ID that is attached on the object. The data will always
# be loaded after a model is being initalized.
module RESTObject
  include MassAssignable
  extend ActiveSupport::Concern

  # after this module is included, set it after_initialize to load the REST data
  included do
    after_initialize :load
  end

  ##
  # Overwrites assign_hash to extract the tiss_id and sets it manually
  # @param [Hash] hash the hash that has been loaded from TISS
  def assign_hash(hash)
    super hash
    hash['tiss_id'] = self.class.get_id(hash)
    create_if_exists hash, 'id', name: :tiss_id
  end

  ##
  # Loads the JSON/XML from TISS with given rest_resource and tiss_id of this
  # object and get a hash of that. Also automatically assigns the hash to the object
  def load
    res = self.class.filter_response(HTTParty.get(self.class.rest_resource + tiss_id).parsed_response)
    assign_hash res
  end

  ##
  # The ClassMethods that the model gets
  module ClassMethods

    ##
    # Load a model from the database given the tiss_id or create a new one and
    # fill it with info
    def load(tiss_id)
      obj = find_by(tiss_id: tiss_id)
      obj = new(tiss_id: tiss_id) if obj.nil?
      resp = filter_response(HTTParty.get(rest_resource + tiss_id).parsed_response)
      obj.assign_hash resp
      obj
    end
  end
end