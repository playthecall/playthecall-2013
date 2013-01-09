# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
PlayTheCall::Application.initialize!

unless Rails.env.test?
  ActiveRecord::Base.logger = Logger.new(STDOUT)
end
