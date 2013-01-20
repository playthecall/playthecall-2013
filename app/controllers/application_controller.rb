class ApplicationController < ActionController::Base
  include ApplicationHelper
  layout 'logged'

  before_filter :choose_locale
  protect_from_forgery

  def choose_locale
    @language   = Translation.for domain: request.host, user: current_user
    I18n.locale = @language
  end

  def load_countries
    @countries = Country.order(:name).joins(:cities).uniq
  end

  protected

  def after_sign_in_path_for(resource)
    root_path
  end
end
