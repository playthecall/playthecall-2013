class WelcomeController < ApplicationController
  layout 'welcome'

  before_filter lambda { redirect_to user_current_mission },
                if: :user_signed_in?

  def index
    @cities = City.joins(:users)
    @users = []
    for city in @cities
      @users << city.users.first(order: "RANDOM()")
    end
  end
end
