class MissionEnrollmentsController < ApplicationController
  prepend_before_filter :authenticate_user!, only: [:new]
  prepend_before_filter :load_mission_enrollment, only: :show

  before_filter :load_mission, only: [:new, :edit]
  before_filter :load_mission_enrollments, only: :show

  def new
    unless current_user.current_mission_enrollment && current_user.current_mission_enrollment.accomplished?
      redirect_to root_path
    end
  end

  def show
    @mission_enrollment.lazy_check
  end

  def check
    @enrollment = MissionEnrollment.find_by_url "m/#{params[:nickname]}/#{params[:slug]}"
    render text: @enrollment.async_check(params)
  end

  def update
    mission_id = Mission.find_by_slug(params[:mission_id]).id
    mission_enrollment = MissionEnrollment.find_by_mission_id_and_user_id(mission_id, current_user.id)
    mission_enrollment.update_attributes(params[:mission_enrollment])
    mission_enrollment.save
    redirect_to mission_enrollment_path nickname: mission_enrollment.user.nickname,
                                        slug:     mission_enrollment.mission.slug
  end

  def create
    if current_user.current_mission_enrollment && current_user.current_mission_enrollment.accomplished?
      mission_enrollment = MissionEnrollment.create params[:mission_enrollment]
      redirect_to mission_enrollment_path nickname: mission_enrollment.user.nickname,
                                          slug:     mission_enrollment.mission.slug
    else
      redirect_to root_path
    end
  end

  private
  def load_mission_enrollment
    nickname = params[:nickname]
    slug = params[:slug]
    @user = User.find_by_nickname nickname
    @mission_enrollment = @user.mission_enrollments.joins(:mission).
                                where('missions.slug = ?', slug).first
  end

  def load_mission_enrollments
    @enrolled_missions = current_user.mission_enrollments.dup
    @enrolled_missions.delete_if { |enrollment| enrollment.id == @mission_enrollment.id }
  end

  def load_mission
    @mission = current_user.current_chapter.missions.find_by_slug params[:mission_id]
  end
end
