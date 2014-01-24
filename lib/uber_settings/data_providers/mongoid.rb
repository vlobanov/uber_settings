module UberSettings
  module Mongoid
    def Mongoid.included(klass)
      klass.instance_eval do
        field :_id, type: String, default: ->{ name }
        field :name, type: String
        field :value
        field :need_to_deserialize, type: Boolean
        
        extend(ClassMethods)
      end
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

    
    module ClassMethods
      def set_value(name, value)
        setting = find_or_initialize_by(name: name.to_s)
        setting.set_value_with_serialization(value)
        setting.save!
      end

      def get_value(name)
        find(name.to_s).restored_value
      end
    end
  end
end