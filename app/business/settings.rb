class Settings < Settingslogic
  source "#{Rails.root}/config/application/#{Rails.env}.yml"
end