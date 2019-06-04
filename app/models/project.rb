class Project < ApplicationRecord
  include Searchable
  include RESTObject

  has_and_belongs_to_many :users

  def assign_hash(hash)
    super hash
    create_if_exists hash, 'title', name: :p_title
    create_if_exists hash, 'titleDe', name: :p_title
    create_if_exists hash, 'short', name: :p_short
    create_if_exists hash, 'keywords', 'keyword', 'de', name: :p_short
    create_if_exists hash, 'researchAreas', 'researchArea', 'name', 'de', name: :p_research_area
    create_if_exists hash, 'financiers', 'financier', 'de', name: :p_financier
    create_if_not_exists hash, 'detail_url', 'https://tiss.tuwien.ac.at/fpl/project/index.xhtml?id=' + tiss_id, name: :detail_url
  end

  def self.tiss_search_link
    "https://tiss.tuwien.ac.at/api/search/projectFullSearch/v1.0/projects?searchterm="
  end

  def self.get_id(hash)
    return hash['id'] if hash.key?('id')

    hash['tuVienna']['project']['id'] if hash.key?('tuVienna')
  end

  def self.filter_response(response)
    response['tuVienna']['project']
  end

  def self.rest_resource
    # + project ID
    'https://tiss.tuwien.ac.at/api/pdb/rest/project/v2/'
  end

end
