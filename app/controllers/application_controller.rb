class ApplicationController < ActionController::Base
  before_filter :choose_locale
  before_filter :redirect_to_countdown
  protect_from_forgery

  def choose_locale
    I18n.locale = Translation.for domain: request.host, user: current_user
  end

  protected
  def redirect_to_countdown
    if Rails.env.production? && Time.new(2012, 12, 21) > Time.now
      redirect_to controller: :welcome, action: :countdown
    end
  end
end
