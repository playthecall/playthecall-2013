class UsersController < ApplicationController
  def edit
    @user = User.find params[:id]
  end

  def show
    @user = User.find params[:id]
  end
end
