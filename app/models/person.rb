class Person < ApplicationRecord
  include Searchable

  attr_accessor :first_name, :last_name, :gender, :prefix_title,
                :postfix_title, :image, :link

  has_and_belongs_to_many :users

  def initialize(parray)
    @id = parray['id']
    @first_name = parray['firstname']
    @last_name = parray['lastname']
    @gender = parray['gender']
    @prefix_title = parray['prefixTitle']
    @postfix_title = parray['postfixTitle']
    @image = parray['adressbuch_benutzerbild']
    @link = parray['adressbuch_visitenkarte']
  end

  def self.tiss_search_link
    "https://tiss.tuwien.ac.at/api/person/v21/psuche?q="
  end
end