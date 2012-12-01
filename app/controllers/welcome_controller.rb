class WelcomeController < ApplicationController
  layout false

  def index
    redirect_to user_path current_user and return if user_signed_in?
    render :countdown and return
    @cities = City.joins(:users)
    @users = []
    for city in @cities
      @users << city.users.first(order: "RANDOM()")
    end
  end
end
