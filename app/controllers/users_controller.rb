class UsersController < ApplicationController
  before_filter :authenticate_user!

  def edit
    @user = logged_user params[:id]
  end

  def update
    @user = logged_user params[:id]
    if @user.update_attributes params[:user]
      redirect_to missions_path
    else
      render :edit
    end
  end

  private

  def logged_user(id)
    user = User.find id
    if current_user == user
      user
    else
      redirect_to :root
    end
  end
end
