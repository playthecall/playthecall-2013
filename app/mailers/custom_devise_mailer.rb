# Overwrite the default Devise mailer
# For more info: https://github.com/plataformatec/devise/wiki/How-To:-Use-custom-mailer
class CustomDeviseMailer < Devise::Mailer
  helper :application # Includes application helpers
end
