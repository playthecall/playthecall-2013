class MissionsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @user    = current_user
    @mission = @user.current_mission_enrollment.mission
    render :show
  end

  def show
    @user    = current_user
    @mission = Mission.find params[:id]
  end
end
