require "mongoid"

class MongoidSettingsDataProvider
  include Mongoid::Document
  include UberSettings::Mongoid
end