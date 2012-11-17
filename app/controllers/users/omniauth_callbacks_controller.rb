class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
     redirect_to 'users/sign_up'
  end
end
