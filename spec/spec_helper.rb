require 'rubygems'
require 'bundler/setup'

require 'uber_settings'

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../dummy/config/environment", __FILE__)

Dir["./spec/support/**/*.rb"].sort.each {|f| require f}

RSpec.configure do |config|
  # some (optional) config here
end