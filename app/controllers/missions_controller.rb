class MissionsController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user    = current_user
    @mission = current_user.current_mission
  end
end
