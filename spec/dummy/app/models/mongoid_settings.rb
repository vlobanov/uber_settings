require "mongoid"

class MongoidSettings
  include Mongoid::Document
  field :name, type: String
  field :value
  field :_id, type: String, default: ->{ name }

  def self.set_value(name, value)
    setting = find_or_initialize_by(name: name.to_s)
    setting.value = value
    setting.save!
  end

  def self.get_value(name)
    find(name.to_s).value
  end
end