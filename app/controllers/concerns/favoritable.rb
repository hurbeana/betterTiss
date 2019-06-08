##
# Module that adds the favorite path to the controller
module Favoritable
  extend ActiveSupport::Concern

  ##
  # Favorites or unfavorites the object that is associated to this controller
  # (with the user), provided that everything else is here (relationship and the
  # models).
  #
  # @author Hurbean Alexander
  def favorite
    type = params[:type] # get the type from the url (fav/unfav)
    ass = params[:controller] # get the current controller name
    clazz = params[:controller].classify.constantize # get the controllers class in with big upper letter
    obj = clazz.find_by tiss_id: params[:tiss_id] # find the object with the tiss_id
    obj = clazz.create tiss_id: params[:tiss_id] if obj.nil? # create if not exists
    alreadyfav = current_user.send(ass).exists?(obj.id) # is it already fav?
    if type == 'favorite' && !alreadyfav # if not already fav and we want to fav
      current_user.send(ass) << obj # fav it
      flash[:success] = "Favorite successful" # success msg
    elsif type == 'unfavorite' && alreadyfav # else
      current_user.send(ass).delete(obj) # unfav
      flash[:success] = "Unfavorite successful" # success msg
    else
      flash[:danger] = "Nothing happened" # nothing happened msg
    end
    redirect_back fallback_location: root_path # return
  end
end