##
# This class represents a thesis (from Tiss) and it's attributes.
class Thesis < ApplicationRecord

  ##
  # Includes
  # concerns for search, load, and assign functionality.
  include Searchable
  include RESTObject

  THESIS_ID_REG = /\d{5}/ # filter for the thesis id out a url

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
    create_if_exists hash, 'title', 'de', name: :t_title
    create_if_exists hash, 'title', 'en', name: :t_title unless hash.key?('t_title')
    create_if_exists hash, 'title', name: :t_title unless hash.key?('t_title')

    create_if_exists hash, 'short', name: :t_short
    create_if_exists hash, 'keywords', 'de', name: :t_short
    create_if_exists hash, 'thesisType', name: :t_thesis_type
    create_if_exists hash, 'instituteName', 'de', name: :t_institute_name
    create_if_exists hash, 'instituteCode', name: :t_institute_code
    create_if_exists hash, 'facultyName', 'de', name: :t_faculty_name
    create_if_exists hash, 'facultyCode', name: :t_faculty_code
    create_if_exists hash, 'url', name: :detail_url

    create_if_exists hash, 'advisor', 'oid', name: :t_advisor_oid
    create_if_exists hash, 'advisor', 'familyName', name: :t_advisor_family_name
    create_if_exists hash, 'advisor', 'givenName', name: :t_advisor_given_name
    create_if_exists hash, 'advisor', 'prefixTitle', name: :t_advisor_prefix_title
    create_if_exists hash, 'advisor', 'postfixTitle', name: :t_advisor_postfix_title

    create_if_exists hash, 'assistant', 'oid', name: :t_assistant_oid
    create_if_exists hash, 'assistant', 'familyName', name: :t_assistant_family_name
    create_if_exists hash, 'assistant', 'givenName', name: :t_assistant_given_name
    create_if_exists hash, 'assistant', 'prefixTitle', name: :t_assistant_prefix_title
    create_if_exists hash, 'assistant', 'postfixTitle', name: :t_assistant_postfix_title
  end

  ##
  # The search link for these entities, without the search query at the end.
  # Used to get an array of search results after parsing of the response.
  def self.tiss_search_link
    'https://tiss.tuwien.ac.at/api/search/thesis/v1.0/quickSearch?searchterm='
  end

  ##
  # Returns the Tiss id of one specific (this) entity.
  def self.get_id(hash)
    return hash['id'] if hash.key?('id')

    get_thesis_id(hash['tuvienna']['thesis']['url']) if hash.key?('tuvienna')
  end

  ##
  # Defines the proper entry point (start node) in the hash (from the XML/JSON response) for this entity.
  def self.filter_response(response)
    response['tuvienna']['thesis']
  end

  ##
  # The link for the detailed information of one entity, without the entity id at the end.
  def self.rest_resource
    # + Thesis ID
    'https://tiss.tuwien.ac.at/api/thesis/'
  end

  ##
  # To get the id of a thesis from a link using the defined regex.
  # @param [String] link The line that contains the required thesis id.
  def self.get_thesis_id(link)
    link.scan(THESIS_ID_REG).first
  end

end
