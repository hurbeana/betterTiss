##
# This class represents a person (from Tiss) and it's attributes.
class Person < ApplicationRecord

  ##
  # Includes
  # concerns for search, load, and assign functionality.
  include Searchable
  include RESTObject

  ##
  # Database relation
  # Needed so that this can be a favorite of a user.
  has_and_belongs_to_many :users

  ##
  # Hash assignment
  # Assigning custom hashes if they are present in the parsed result entity.
  # Two (or more) different assignments to same key if their names differ from search result to detail result.
  def assign_hash(hash)
    super hash
    if hash.key? 'picture_uri'
      ill_reg = /\/illustration.*/
      hash['picture_uri'] = hash['picture_uri'].scan(ill_reg).first
    end
    create_if_not_exists hash, 'adressbuch_visitenkarte', "/person/" + self.tiss_id, name: :p_link
    create_if_exists hash, 'adressbuch_visitenkarte', name: :p_link
    create_if_exists hash, 'adressbuch_benutzerbild', name: :p_image
    create_if_exists hash, 'picture_uri', name: :p_image
    create_if_exists hash, 'preceding_titles', name: :prefixTitle
    create_if_exists hash, 'postpositioned_titles', name: :postfixTitle
    create_if_exists hash, 'main_email', name: :email
  end

  ##
  # The search link for these entities, without the search query at the end.
  # Used to get an array of search results after parsing of the response.
  def self.tiss_search_link
    "https://tiss.tuwien.ac.at/api/person/v21/psuche?q="
  end

  ##
  # The link for the detailed information of one entity, without the entity id at the end.
  def self.rest_resource
    'https://tiss.tuwien.ac.at/api/person/v21/id/'
  end

  ##
  # Returns the Tiss id of one specific (this) entity.
  def self.get_id(hash)
    hash['id']
  end

  ##
  # Defines the proper entry point (start node) in the hash (from the XML/JSON response) for this entity.
  def self.filter_response(response)
    response['tuvienna']['person']
  end
end