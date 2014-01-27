#require 'simplecov'
#SimpleCov.start

require 'rubygems'
require 'bundler/setup'
require 'database_cleaner'
require 'uber_settings'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../dummy/config/environment", __FILE__)

Dir["./spec/support/**/*.rb"].sort.each {|f| require f}

RSpec.configure do |config|
  config.mock_with :mocha

  config.before(:suite) do
    #just in case
    DatabaseCleaner[:active_record].strategy = :truncation
    DatabaseCleaner[:active_record].clean_with(:truncation)
    DatabaseCleaner[:mongoid].strategy = :truncation
    DatabaseCleaner[:mongoid].clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end