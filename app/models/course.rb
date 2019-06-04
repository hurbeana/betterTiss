class Course < ApplicationRecord
  include Searchable
  include RESTObject

  COURSE_NR_REG = /[\dA-Z]{6}/
  SEMESTER_REG = /\d{4}[SW]/

  has_and_belongs_to_many :users

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

  def self.tiss_search_link
    "https://tiss.tuwien.ac.at/api/search/course/v1.0/quickSearch?searchterm="
  end

  def self.get_id(hash)
    return get_course_nr(hash['detail_url']) + '-' + get_semester(hash['detail_url']) if hash.key?('detail_url')
    hash['tuvienna']['course']['courseNumber'] + '-' + hash['tuvienna']['course']['semesterCode'] if hash.key?('tuvienna')
  end

  def self.filter_response(response)
    response['tuvienna']['course']
  end

  def self.rest_resource
    'https://tiss.tuwien.ac.at/api/course/'
  end

  def self.get_course_nr(link)
    link.scan(COURSE_NR_REG).first
  end

  def self.get_semester(link)
    link.scan(SEMESTER_REG).first
  end
end
