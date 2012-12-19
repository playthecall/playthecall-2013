class MissionsController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user    = current_user
    @mission = Mission.for_user(current_user).find_by_slug params[:id]
  end
end
