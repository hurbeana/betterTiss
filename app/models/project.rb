##
# This class represents a project (from Tiss) and it's attributes.
class Project < ApplicationRecord

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
    create_if_exists hash, 'title', name: :p_title
    create_if_exists hash, 'titleDe', name: :p_title
    create_if_exists hash, 'short', name: :p_short
    create_if_exists hash, 'abstractDe', name: :p_short
    create_if_exists hash, 'researchAreas', 'researchArea', 'name', 'de', name: :p_research_area
    create_if_exists hash, 'financiers', 'financier', 'de', name: :p_financier
    create_if_not_exists hash, 'detail_url', 'https://tiss.tuwien.ac.at/fpl/project/index.xhtml?id=' + tiss_id, name: :detail_url
  end

  ##
  # The search link for these entities, without the search query at the end.
  # Used to get an array of search results after parsing of the response.
  def self.tiss_search_link
    'https://tiss.tuwien.ac.at/api/search/projectFullSearch/v1.0/projects?searchterm='
  end

  ##
  # Returns the Tiss id of one specific (this) entity.
  def self.get_id(hash)
    return hash['id'] if hash.key?('id')

    hash['tuVienna']['project']['id'] if hash.key?('tuVienna')
  end

  ##
  # Defines the proper entry point (start node) in the hash (from the XML/JSON response) for this entity.
  def self.filter_response(response)
    response['tuVienna']['project']
  end

  ##
  # The link for the detailed information of one entity, without the entity id at the end.
  def self.rest_resource
    # + project ID
    'https://tiss.tuwien.ac.at/api/pdb/rest/project/v2/'
  end

end
