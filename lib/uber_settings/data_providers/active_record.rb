module UberSettings
  module ActiveRecord
    def ActiveRecord.included(klass)
      klass.instance_eval do
        extend(ClassMethods)
      end
    end
    
    module ClassMethods
      def set_value(name, value)
        setting = find_or_initialize_by(name: name.to_s)
        setting.value = Marshal.dump(value)
        setting.save!
      end

      def get_value(name)
        value = find_by(name: name.to_s).value
        Marshal.load(value)
      end
    end
  end
end