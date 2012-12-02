class MissionEnrollmentsController < ApplicationController
  before_filter :authenticate_user!, only: [:new]
  def check
    @enrollment = MissionEnrollment.find_by_url "m/#{params[:nickname]}/#{params[:slug]}"
    render text: @enrollment.check(params)
  end

  def index
    @user = current_user if user_signed_in?
    @enrollment = MissionEnrollment.find_by_url "m/#{params[:nickname]}/#{params[:slug]}"
  end

  def new
    @user = current_user
    @mission = Mission.find params[:mission_id]
  end
end
