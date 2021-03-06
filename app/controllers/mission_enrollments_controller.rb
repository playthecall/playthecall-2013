class MissionEnrollmentsController < ApplicationController
  prepend_before_filter :authenticate_user!, only: [:new]

  before_filter :load_mission, only: [:new, :edit, :create]
  before_filter :load_mission_enrollments, only: :show

  def new
    if current_user.can_enroll?(@mission)
      @mission_enrollment = @mission.enroll current_user
    else
      redirect_to root_path
    end
  end

  def show
    @mission_enrollment.lazy_check
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

  def update
    mission_id = Mission.find_by_slug(params[:mission_id]).id
    mission_enrollment = MissionEnrollment.find_by_mission_id_and_user_id(mission_id, current_user.id)
    mission_enrollment.update_attributes(params[:mission_enrollment])
    mission_enrollment.save
    redirect_to mission_enrollment_path nickname: mission_enrollment.user.nickname,
                                        slug:     mission_enrollment.mission.slug
  end

  def create
    if current_user.can_enroll?(@mission)
      @mission_enrollment = MissionEnrollment.new params[:mission_enrollment]
      if @mission_enrollment.save
          redirect_to mission_enrollment_path nickname: @mission_enrollment.user.nickname,
                                              slug:     @mission_enrollment.mission.slug
      else
        render :new
      end
    else
      redirect_to root_path
    end
  end

  private
  def load_mission_enrollments
    slug = params[:slug]
    @user = User.find_by_nickname params[:nickname]
    @mission_enrollment = @user.mission_enrollments.joins(:mission).
                                where('missions.slug = ?', slug).first
    @enrolled_missions = @user.mission_enrollments.dup
    @enrolled_missions.delete_if { |e| e.id == @mission_enrollment.id }
  end

  def load_mission
    @mission = current_user.current_chapter.missions.find_by_slug params[:mission_id]
  end
end
