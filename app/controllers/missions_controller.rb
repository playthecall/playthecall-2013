class MissionsController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user    = current_user
    @mission = Mission.find_by_slug params[:id]
  end
end
