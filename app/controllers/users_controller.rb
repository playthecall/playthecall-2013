class UsersController < ApplicationController
  include ApplicationHelper

  before_filter :authenticate_user!
  before_filter :check_users
  before_filter :load_user_country
  before_filter :load_countries
  before_filter :load_cities

  def edit
  end

  def update
    if @user.update_attributes params[:user]
      redirect_to user_current_mission
    else
      render :edit
    end
  end

  private

  def check_users
    @user = User.find params[:id]
    redirect_to :root unless current_user == @user
  end

  def load_user_country
    @country = @user.city.country
  end

  def load_cities
    @cities = City.where(:country_id => @country.id)
  end
end
