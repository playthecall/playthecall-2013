class WelcomeController < ApplicationController
  layout false

  skip_before_filter :redirect_to_countdown, :only => :countdown

  def index
    if user_signed_in?
      redirect_to mission_path(Mission.version(current_user.game_version_id).first)
      return
    end

    @cities = City.joins(:users)
    @users = []
    for city in @cities
      @users << city.users.first(order: "RANDOM()")
    end
  end

  def countdown
    @days_to_release = (Date.new(2012, 12, 21) - Date.today).to_i.to_s.rjust(2, '0')
  end
end
