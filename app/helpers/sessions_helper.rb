##
# Various helpers that help with checking on the users session
module SessionsHelper

  ##
  # Is given user logged in
  # @param user the user that is to be checked whether he/she is the one logged in
  def log_in(user)
    session[:user_id] = user.id
  end

  ##
  # Remembers a user in a persistent session.
  # @param user permanently remember given user
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  ##
  # Forgets a persistent session.
  # @param user forget persistent session of given user
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  ##
  # Log out currently logged in user and delete permanent session
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  ##
  # Is given user currently logged in user?
  # @param user user to be checked
  def current_user?(user)
    user == current_user
  end

  ##
  # Get currently logged in user
  # @return [User] currently logged in user
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user&.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  ##
  # Is any user logged in?
  def logged_in?
    !current_user.nil?
  end

  ##
  # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  ##
  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
