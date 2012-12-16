# encoding: utf-8
require 'rubygems'

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)

require 'pry'
require 'rspec/rails'
require 'rspec/autorun'
require 'database_cleaner'
require 'capybara/poltergeist'

Dir[Rails.root.join("spec/support/**/*.rb")].each{ |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec

  config.extend DatabaseCleanerHelper

  config.include FactoryGirl::Syntax::Methods
  config.use_transactional_fixtures = false
end

Capybara.javascript_driver = :poltergeist

DatabaseCleaner.clean_with :truncation
