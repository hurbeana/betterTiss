module Favoritable
  extend ActiveSupport::Concern

  def favorite
    type = params[:type]
    ass = params[:controller]
    clazz = params[:controller].classify.constantize
    obj = clazz.find_by tiss_id: params[:tiss_id]
    obj = clazz.create tiss_id: params[:tiss_id] if obj.nil?
    alreadyfav = current_user.send(ass).exists?(obj.id)
    if type == 'favorite' && !alreadyfav
      current_user.send(ass) << obj
      flash[:success] = "Favorite successful"
    elsif type == 'unfavorite' && alreadyfav
      current_user.send(ass).delete(obj)
      flash[:success] = "Unfavorite successful"
    else
      flash[:danger] = "Nothing happened"
    end
    redirect_back fallback_location: root_path
  end
end