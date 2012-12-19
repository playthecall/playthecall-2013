class MissionsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :welcome_message_logic, :only => [:show]

  def show
    @user = current_user
    @mission = Mission.for_user(current_user).find_by_slug params[:id]
  end

  def welcome
  end

  private

  def welcome_message_logic
    if current_user.sign_in_count == 1 && session[:saw_welcome_message].nil?
      session[:saw_welcome_message] = true
      redirect_to :action => 'welcome'
    end
  end
end
