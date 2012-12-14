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

  def show
    nickname = params[:nickname]
    slug = params[:slug]
    @user = User.find_by_nickname nickname
    @mission_enrollment = @user.mission_enrollments.joins(:mission).
                                where('missions.slug = ?', slug).first
  end

  def new
    @user = current_user
    @mission = Mission.find params[:mission_id].split("mission-")[1]
  end

  def edit
    @user = current_user
    @mission_enrollment = MissionEnrollment.find params[:id]
  end

  def update
    mission_id = params[:mission_id].split("mission-")[1]
    mission_enrollment = MissionEnrollment.find_by_mission_id_and_user_id(mission_id, current_user.id)
    mission_enrollment.update_attributes(params[:mission_enrollment])
    mission_enrollment.save
    redirect_to mission_enrollment_path nickname: mission_enrollment.user.nickname,
                                        slug:     mission_enrollment.mission.slug
  end

  def create
    mission_enrollment_attributes = params[:mission_enrollment]
    mission_enrollment = MissionEnrollment.create mission_enrollment_attributes
    redirect_to mission_enrollment_path nickname: mission_enrollment.user.nickname,
                                        slug:     mission_enrollment.mission.slug
  end
end
