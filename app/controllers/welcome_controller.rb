class WelcomeController < ApplicationController
  layout 'welcome'
  before_filter :mission_redirect

  def index
    @users = User.includes(:city).group(:city_id).order('RANDOM()')
  end

  private

  def mission_redirect
    if user_signed_in?
      if current_user.current_mission.present?
        redirect_to user_current_mission
      elsif Chapter.finished?(current_user.current_chapter, current_user)
        redirect_to end_of_chapter_path
      end
    end
  end
end
