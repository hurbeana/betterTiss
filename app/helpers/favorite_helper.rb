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

  ##
  # Gets the date when the object has been favorited
  # @return date when the given object has been favorited by user
  def favorited_at(obj)
    return nil if obj.nil?
    return nil if params[:controller] != 'users'

    objtype = obj.class.name.downcase
    ass = obj.class.name.pluralize.downcase
    id = params[:id]
    query = "select created_at from #{ass}_users where #{objtype}_id = #{obj.id} and user_id = #{id}"
    ActiveRecord::Base.connection.exec_query(query).first["created_at"]
  end
end