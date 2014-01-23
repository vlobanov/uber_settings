$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "uber_settings/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "uber_settings"
  s.version     = UberSettings::VERSION
  s.authors     = ["Vadim Lobanov"]
  s.email       = ["vadim@lobanov.pw"]
  s.homepage    = ""
  s.summary     = "Gem allowing to store and change domain specific settings using YAML files, ActiveRecord or Mongoid"
  s.description = "I have barely written summary"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.0.0"

  s.add_development_dependency "rspec"
  s.add_development_dependency "database_cleaner"
end
