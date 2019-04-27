class Person < ApplicationRecord
  attr_accessor :first_name, :last_name, :gender, :prefix_title,
                   :postfix_title, :image, :link

  has_and_belongs_to_many :users

  def initialize(p)
    @id = p['id']
    @first_name = p['firstname']
    @last_name = p['lastname']
    @gender = p['gender']
    @prefix_title = p['prefixTitle']
    @postfix_title = p['postfixTitle']
    @image = p['adressbuch_benutzerbild']
    @link = p['adressbuch_visitenkarte']
  end


  def self.tiss_search_link
    "https://tiss.tuwien.ac.at/api/person/v21/psuche?q="
  end
end