require 'spec_helper'

Capybara.javascript_driver = :poltergeist

RSpec.configure do |config|
  config.include ActionView::Helpers::TranslationHelper
end

def login(user)
  visit new_user_session_path
  fill_in t('activerecord.attributes.user.email'), with: user.email
  fill_in t('activerecord.attributes.user.password'), with: user.password
  click_button t('actions.sign_in')
end
