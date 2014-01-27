require 'uber_settings/exceptions'

module UberSettings
  module Mongoid
    def Mongoid.included(klass)
      klass.instance_eval do
        field :_id, type: String, default: ->{ name }
        field :name, type: String
        field :value
        field :value_type, type: String
        field :need_to_deserialize, type: Boolean
        
        extend(ClassMethods)
      end
    end

    def restore_value_after_serialization
      if need_to_deserialize
        Marshal::load(value)
      else
        value
      end
    end

    def set_value_with_serialization(new_value)
      self.value =  if new_value.respond_to? :bson_type
                      self.need_to_deserialize = false
                      new_value
                    else
                      self.need_to_deserialize = true
                      Marshal.dump(new_value)
                    end
    end

    
    module ClassMethods
      include ProviderBehavior::ClassMethods
    end
  end
end