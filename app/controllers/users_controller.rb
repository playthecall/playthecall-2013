class UsersController < ApplicationController
  include ApplicationHelper

  before_filter :authenticate_user!
  before_filter :check_users

  def edit
  end

  def update
    if @user.update_attributes params[:user]
      redirect_to user_current_mission
    else
      render :edit
    end
  end

  private

  def check_users
    @user = User.find params[:id]
    redirect_to :root unless current_user == @user
  end
end
