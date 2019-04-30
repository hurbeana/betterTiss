module FavoriteHelper
  def favorite?(obj)
    ass = obj.class.name.pluralize.downcase
    obj.nil? ? false : current_user.send(ass).exists?(obj.id)
  end
end