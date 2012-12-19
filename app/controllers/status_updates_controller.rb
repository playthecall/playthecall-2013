class StatusUpdatesController < ApplicationController
  prepend_before_filter :authenticate_user!, :load_mission_enrollment
  before_filter         :load_status_update, :validate_current_user

  def create
    @status_update = StatusUpdate.new(params[:status_update])
    if @status_update.save
      redirect_to mission_enrollment_path(current_user.nickname, @mission_enrollment.mission.slug)
    else
      render "new"
    end
  end

  def update
    if @status_update.update_attributes params[:status_update]
      redirect_to mission_enrollment_path(current_user.nickname, @mission_enrollment.mission.slug)
    else
      render "edit"
    end
  end

  def destroy
    @status_update.delete
    redirect_to mission_enrollment_path(current_user.nickname, @mission_enrollment.mission.slug)
  end

  private
  def load_mission_enrollment
    @mission_enrollment = MissionEnrollment.find params[:mission_enrollment_id]
  end

  def load_status_update
    status_update
  end

  def status_update
    @status_update ||= if params[:id].present?
      StatusUpdate.find(params[:id])
    else
      @mission_enrollment.status_updates.build
    end
  end

  def validate_current_user
    render text: I18n.t("actions.unauthorized"),
      status: 401 unless status_update.mission_enrollment.user == current_user
    return
  end
end
