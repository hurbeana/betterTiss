class Person < ApplicationRecord
  include Searchable
  include RESTObject

  has_and_belongs_to_many :users

  def assign_hash(hash)
    super hash
    if hash.key? 'picture_uri'
      ill_reg = /\/illustration.*/
      hash['picture_uri'] = hash['picture_uri'].scan(ill_reg).first
    end
    create_if_exists hash, 'adressbuch_visitenkarte', name: :p_link
    create_if_exists hash, 'adressbuch_benutzerbild', name: :p_image
    create_if_exists hash, 'picture_uri', name: :p_image
    create_if_exists hash, 'preceding_titles', name: :prefixTitle
    create_if_exists hash, 'postpositioned_titles', name: :postfixTitle
    create_if_exists hash, 'main_email', name: :email
  end

  def self.tiss_search_link
    "https://tiss.tuwien.ac.at/api/person/v21/psuche?q="
  end

  def self.rest_resource
    'https://tiss.tuwien.ac.at/api/person/v21/id/'
  end

  def self.get_id(hash)
    hash['id']
  end

  def self.filter_response(response)
    response['tuvienna']['person']
  end
end