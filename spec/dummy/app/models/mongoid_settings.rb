require "mongoid"

class MongoidSettings
  include Mongoid::Document
  field :_id, type: String, default: ->{ name }
  field :name, type: String
  field :value
  field :need_to_deserialize, type: Boolean

  def self.set_value(name, value)
    setting = find_or_initialize_by(name: name.to_s)
    setting.set_value_with_serialization(value)
    setting.save!
  end

  def self.get_value(name)
    find(name.to_s).restored_value
  end

  def restored_value
    if need_to_deserialize
      Marshal::load(value)
    else
      value
    end
  end

  def set_value_with_serialization(value)
    self.value =  if value.respond_to? :bson_type
                    self.need_to_deserialize = false
                    value
                  else
                    self.need_to_deserialize = true
                    Marshal.dump(value)
                  end
  end
end