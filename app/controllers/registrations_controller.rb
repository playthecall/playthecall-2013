class RegistrationsController < Devise::RegistrationsController
  before_filter :load_countries

  def new
    @cities = []
    super
  end

  def create
    @cities = City.where(:country_id => params[:user][:country_id])
    super
  end

  def edit
    super
  end

  def update
    super
  end

end
