require "mongoid"

class MongoidSettings
  include Mongoid::Document
  include UberSettings::Mongoid
end