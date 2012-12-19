class MissionEnrollmentsController < ApplicationController
  prepend_before_filter :authenticate_user!, only: [:new]
  prepend_before_filter :load_mission_enrollment, only: :show

  before_filter :load_mission, only: [:new, :edit]
  before_filter :load_mission_enrollments, only: :show

  def new
    @mission_enrollment = @mission.enroll current_user
  end

  def check
    @mission_enrollment = MissionEnrollment.find_by_url "m/#{params[:nickname]}/#{params[:slug]}"
    @mission_enrollment.async_check(params)
    redirect_to mission_enrollment_path nickname: @mission_enrollment.user.nickname,
                                        slug:     @mission_enrollment.mission.slug
  end

  def index
    @user = current_user if user_signed_in?
    @enrollment = MissionEnrollment.find_by_url "m/#{params[:nickname]}/#{params[:slug]}"
  end

  def show
    @mission_enrollment.lazy_check
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
    mission_enrollment = MissionEnrollment.new params[:mission_enrollment]

    if mission_enrollment.valid?
      if mission_enrollment.validator.before_create(params)
        mission_enrollment.save
        redirect_to mission_enrollment_path nickname: mission_enrollment.user.nickname,
                                            slug:     mission_enrollment.mission.slug
        return
      end
    end

    render :new
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
