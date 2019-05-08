class Thesis < ApplicationRecord
  include Searchable
  include RESTObject

  THESIS_ID_REG = /\d{5}/

  has_and_belongs_to_many :users

  def self.tiss_search_link
    "https://tiss.tuwien.ac.at/api/search/thesis/v1.0/quickSearch?searchterm="
  end

  def self.get_id(hash)
    return hash["id"] if hash.key?('id')
    get_thesis_id(hash['tuvienna']['thesis']['url']) if hash.key?('tuvienna')
  end

  def self.filter_response(response)
    response['tuvienna']['thesis']
  end

  def self.rest_resource
    # + Thesis ID
    'https://tiss.tuwien.ac.at/api/thesis/'
  end

  def self.get_thesis_id(link)
    link.scan(THESIS_ID_REG).first
  end

end
