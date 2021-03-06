# common behavior for AR and mongoid data providers. since they basicaly have same interfaces
# only have to care about serialization

module UberSettings
  module ProviderBehavior
    module ClassMethods
      def set_value(name, value)
        setting = find_setting(name)
        check_new_value!(setting, value)
        setting.set_value_with_serialization(value)
        setting.save!
      end

      def get_value(name)
        find_setting(name).restore_value_after_serialization
      end

      def create_setting_with_default(name, default_value, options = {})
        setting = find_or_initialize_by(name: name.to_s)
        setting.set_value_with_serialization(default_value) unless setting.persisted?
        set_value_type!(setting, options)
        setting.save!
      end

      private
        def check_new_value!(setting, value)
          unless setting.value_type.blank?
            value_type = setting.value_type.to_sym
            unless DATA_TYPES_PREDICATES[value_type].call(value)
              raise InvalidSettingValueType, "Expected #{value_type}, got value of #{value.class.name}"
            end
          end
        end

        def set_value_type!(setting, options)
          if options[:type] 
            raise UnknownSettingValueType unless DATA_TYPES.include?(options[:type])
            setting.value_type = options[:type].to_s
          end
        end

        def find_setting(name)
          setting = where(name: name.to_s).first
          raise(SettingNotFound, name.to_s) unless setting

          setting
        end
    end
  end
end