##
# This class represents a course (from Tiss) and it's attributes.
class Course < ApplicationRecord

  ##
  # Includes
  # concerns for search, load, and assign functionality.
  include Searchable
  include RESTObject

  COURSE_NR_REG = /[\dA-Z]{6}/
  SEMESTER_REG = /\d{4}[SW]/

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
    create_if_exists hash, 'title', 'de', name: :c_title
    create_if_exists hash, 'title', name: :c_title
    create_if_exists hash, 'detail_url', name: :c_link
    create_if_exists hash, 'url', name: :c_link
    create_if_exists hash, 'short', name: :c_short
    create_if_exists hash, 'objective', 'de', name: :c_short
    create_if_exists hash, 'teachingContent', 'de', name: :c_teaching_content
    create_if_exists hash, 'additionalInformation', 'de', name: :c_additional_information
    create_if_exists hash, 'lectureNotes', 'de', name: :c_lecture_notes
    create_if_exists hash, 'instituteName', 'de', name: :c_institute_name
    create_if_exists hash, 'instituteCode', name: :c_institute_code

  end

  ##
  # The search link for these entities, without the search query at the end.
  # Used to get an array of search results after parsing of the response.
  def self.tiss_search_link
    'https://tiss.tuwien.ac.at/api/search/course/v1.0/quickSearch?searchterm='
  end

  ##
  # Returns the Tiss id of one specific (this) entity.
  def self.get_id(hash)
    return get_course_nr(hash['detail_url']) + '-' + get_semester(hash['detail_url']) if hash.key?('detail_url')

    hash['tuvienna']['course']['courseNumber'] + '-' + hash['tuvienna']['course']['semesterCode'] if hash.key?('tuvienna')
  end

  ##
  # Defines the proper entry point (start node) in the hash (from the XML/JSON response) for this entity.
  def self.filter_response(response)
    response['tuvienna']['course']
  end

  ##
  # The link for the detailed information of one entity, without the entity id at the end.
  def self.rest_resource
    'https://tiss.tuwien.ac.at/api/course/'
  end

  ##
  # To get the course number of a course using the defined regex.
  # @param [String] link The line that contains the required course number.
  def self.get_course_nr(link)
    link.scan(COURSE_NR_REG).first
  end

  ##
  # To get the semester of a course using the defined regex.
  # @param [String] link The line that contains the required semester information.
  def self.get_semester(link)
    link.scan(SEMESTER_REG).first
  end
end
