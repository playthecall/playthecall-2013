class MissionsController < ApplicationController
  layout 'users'

  def show
    @user    = User.first
    @mission = Mission.find params[:id]
  end
end
