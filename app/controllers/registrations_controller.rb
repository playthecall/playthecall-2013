class RegistrationsController < Devise::RegistrationsController
  before_filter :load_countries

  def new
    @cities = []
    if User.limit_exceeded?
      flash[:notice] = I18n.t('registrations.limit_exceeded')
      redirect_to root_path and return
    end
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
