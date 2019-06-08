# frozen_string_literal: true

##
# Controller for Browser Sessions
class SessionsController < ApplicationController

  ##
  # Redirect user to own page on creating session
  def new
    redirect_to current_user if logged_in?
  end

  ##
  # Create a new session (aka login)
  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user&.authenticate(params[:session][:password]) # & for safe navigation
      log_in @user
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      redirect_back_or @user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  ##
  # Log out user
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
