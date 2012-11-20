class MissionsController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user    = current_user
    @mission = Mission.find params[:id]
  end
end
