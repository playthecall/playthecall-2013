class MissionsController < ApplicationController
  layout :layout_by_resource

  before_filter :authenticate_user!
  before_filter :welcome_message_logic, :only => [:show]

  def show
    @user = current_user
    @mission = Mission.for_user(current_user).find_by_slug params[:id]
  end

  def welcome
    @first_mission = Mission.first_mission
  end

  def congratulations
    @user = current_user
    @mission = Mission.for_user(current_user).find_by_slug params[:id]
    @enrolled_missions = @user.mission_enrollments.accomplished
    unless @enrolled_missions.detect{|x| x.mission_id == @mission.id}
      redirect_to(root_path) and return
    end
    @next_mission = @user.mission_enrollments.unaccomplished.first.try(:mission)
  end

  private

  def welcome_message_logic
    if current_user.sign_in_count == 1 && session[:saw_welcome_message].nil?
      session[:saw_welcome_message] = true
      redirect_to :action => 'welcome'
    end
  end

  protected

  def layout_by_resource
    return "static" if action_name == "welcome"
    return 'logged'
  end
end
