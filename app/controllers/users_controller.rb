# frozen_string_literal: true

##
# A Controller to handle all user interactions
class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[index edit update destroy]
  before_action :correct_user,   only: %i[edit update]
  before_action :admin_user,     only: :destroy

  ##
  # Show all users (paginate doesn't work anymore)
  def index
    @users = User.paginate(page: params[:page])
  end

  ##
  # Show one user with given id
  def show
    @user = User.find(params[:id])
  end

  ##
  # Delete a user (if the logged in user is an admin)
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  ##
  # Create new empty user (for signup)
  def new
    @user = User.new
  end

  ##
  # Create new user with data 
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      remember @user
      flash[:success] = 'Welcome to the BetterTiss!'
      redirect_to @user
    else
      render 'new'
    end
  end

  ##
  # Update user profile
  def update
    if @user.update_attributes(user_params)
      flash[:success] = 'Profile updated'
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  # before filters

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = 'Please log in.'
      redirect_to login_url
    end
  end

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
