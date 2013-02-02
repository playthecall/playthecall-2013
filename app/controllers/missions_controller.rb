class MissionsController < ApplicationController
  layout :layout_by_resource

  before_filter :authenticate_user!
  before_filter :welcome_message_logic, :only => [:show]

  def show
    @user = current_user
    @mission = Mission.for_user(current_user).find_by_slug params[:id]
  end

  # GET /missions/:slug/welcome
  # When user comes for the first time
  # he/she will see the Welcome page
  def welcome
    @first_mission = current_user.current_chapter.missions.first_mission
  end

  def congratulations
    @user = current_user
    @mission = Mission.for_user(@user).find_by_slug params[:id]
    @enrolled_missions = @user.mission_enrollments.accomplished
    unless @enrolled_missions.detect{|x| x.mission_id == @mission.id}
      redirect_to(root_path) and return
    end
    @next_mission = @mission.next_mission
  end

  # GET /missions/end_of_chapter
  # When user finish all missions of the chapter
  def end_of_chapter
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
    return "static" if ["welcome","end_of_chapter"].include?(action_name)
    return 'logged'
  end
end
