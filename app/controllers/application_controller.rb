class ApplicationController < ActionController::Base
  include ApplicationHelper
  layout 'logged'

  before_filter :choose_locale
  before_filter :redirect_to_countdown
  protect_from_forgery

  def choose_locale
    @language   = Translation.for domain: request.host, user: current_user
    I18n.locale = @language
  end

  def load_countries
    @countries = Country.order(:name).joins(:cities).uniq
  end

  protected
  def redirect_to_countdown
    if (Rails.env.production? && Time.new(2012, 12, 22, 4, 0, 0) > Time.now) and not
       request.host.include?('herokuapp')
      redirect_to countdown_path
    end
  end

  def after_sign_in_path_for(resource)
    root_path
  end
end
