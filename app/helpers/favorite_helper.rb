##
# Helper for favorite objects
module FavoriteHelper

  ##
  # Used to check whether an object can be a favorite of a user or not.
  # @param obj The object that needs to be checked for favorite functionality.
  def favorite?(obj)
    ass = obj.class.name.pluralize.downcase
    obj.id.nil? ? false : current_user.send(ass).exists?(obj.id)
  end
end