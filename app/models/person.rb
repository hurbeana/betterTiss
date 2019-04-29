class Person < ApplicationRecord
  include Searchable
  include ActiveModel::Conversion

  attr_accessor :first_name, :last_name, :gender, :prefix_title,
                :postfix_title, :p_image, :p_link

  has_and_belongs_to_many :users

  def fill(parray)
    @first_name = parray['firstname']
    @last_name = parray['lastname']
    @gender = parray['gender']
    @prefix_title = parray['prefixTitle']
    @postfix_title = parray['postfixTitle']
    @p_link = parray['adressbuch_visitenkarte']
    @p_image = parray['adressbuch_benutzerbild']
  end

  def self.tiss_search_link
    "https://tiss.tuwien.ac.at/api/person/v21/psuche?q="
  end
end