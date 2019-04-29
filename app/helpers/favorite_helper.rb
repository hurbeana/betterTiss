module FavoriteHelper
  def favorite?(tiss_id)
    ass = params[:controller]
    clazz = params[:controller].classify.constantize
    obj = clazz.find_by tiss_id: tiss_id
    obj.nil? ? false : current_user.send(ass).exists?(obj.id)
  end
end