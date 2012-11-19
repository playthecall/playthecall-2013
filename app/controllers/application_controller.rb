class ApplicationController < ActionController::Base
  before_filter :choose_locale
  protect_from_forgery

  def choose_locale
    binding.pry
    I18n.locale = Translation.for domain: request.host, user: current_user
    binding.pry
  end
end
