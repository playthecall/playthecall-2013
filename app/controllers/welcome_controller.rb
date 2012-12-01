class WelcomeController < ApplicationController
  layout false

  skip_before_filter :redirect_to_countdown, :only => :countdown

  def index
    redirect_to user_path current_user if user_signed_in?

    @cities = City.joins(:users)
    @users = []
    for city in @cities
      @users << city.users.first(order: "RANDOM()")
    end
  end

  def countdown
    @days_to_release = (Date.new(2012, 12, 21) - Date.today).to_i
  end
end
