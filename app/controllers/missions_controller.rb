class MissionsController < ApplicationController
  def show
    @user    = User.first
    @mission = Mission.find params[:id]
  end
end
