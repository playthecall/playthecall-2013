class WelcomeController < ApplicationController
  layout 'welcome'

  before_filter lambda { redirect_to user_current_mission }, if: :user_signed_in?
  skip_before_filter :redirect_to_countdown, only: :countdown

  def index
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
