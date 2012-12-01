class MissionEnrollmentsController < ApplicationController
  def check
    @enrollment = MissionEnrollment.find_by_url "m/#{params[:nickname]}/#{params[:slug]}"
    render text: @enrollment.check params
  end

  def show
    @enrollment = MissionEnrollment.find_by_url "m/#{params[:nickname]}/#{params[:slug]}"
  end
end
