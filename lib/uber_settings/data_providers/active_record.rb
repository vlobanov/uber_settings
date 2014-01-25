require 'uber_settings/data_providers/provider_behavior'

module UberSettings
  module ActiveRecord
    def ActiveRecord.included(klass)
      klass.instance_eval do
        extend(ClassMethods)
      end
    end

    def restore_value_after_serialization
      Marshal::load(value)
    end

    def set_value_with_serialization(new_value)
      self.value = Marshal.dump(new_value)
    end
    
    module ClassMethods
      include ProviderBehavior::ClassMethods
    end
  end
end