class Person < ApplicationRecord
  include Searchable
  include ActiveModel::Conversion

  attr_accessor :firstname, :lastname, :gender, :prefixTitle,
                :postfixTitle, :p_image, :p_link

  has_and_belongs_to_many :users

  def fillarray(parray)
    @firstname = parray['firstname']
    @lastname = parray['lastname']
    @gender = parray['gender']
    @prefixTitle = parray['prefixTitle']
    @postfixTitle = parray['postfixTitle']
    @p_link = parray['adressbuch_visitenkarte']
    @p_image = parray['adressbuch_benutzerbild']
  end

  def fillhash(hash)
    hash.each { |key, value| send("#{key.to_sym}=", value) if respond_to? "#{key.to_sym}="}
    @prefixTitle = hash['preceding_titles']
    @postfixTitle = hash['postpositioned_titles']
    @p_image = hash['picture_uri']
  end

  def self.tiss_search_link
    "https://tiss.tuwien.ac.at/api/person/v21/psuche?q="
  end
end