require 'spec_helper'

Capybara.javascript_driver = :poltergeist

def login(user)
  visit new_user_session_path
  fill_in I18n.t('activerecord.attributes.user.email'), with: user.email
  fill_in I18n.t('activerecord.attributes.user.password'), with: user.password
  click_button I18n.t('actions.sign_in')
end
