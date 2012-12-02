class MissionEnrollmentsController < ApplicationController
  def check
    @enrollment = MissionEnrollment.find_by_url "m/#{params[:nickname]}/#{params[:slug]}"
    render text: @enrollment.check(params)
  end

  def index
    @user = current_user if user_signed_in?
    @enrollment = MissionEnrollment.find_by_url "m/#{params[:nickname]}/#{params[:slug]}"
  end
end
