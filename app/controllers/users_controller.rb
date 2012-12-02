class UsersController < ApplicationController
  before_filter :authenticate_user!

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]
    if @user.update_attributes params[:user]
      redirect_to missions_path
    else
      render :edit
    end
  end
end
