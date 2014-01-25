# common behavior for AR and mongoid data providers. since they basicaly have same interfaces
# only have to care about serialization

module UberSettings
  module ProviderBehavior
    module ClassMethods
      def set_value(name, value)
        setting = find_setting(name)
        setting.set_value_with_serialization(value)
        setting.save!
      end

      def get_value(name)
        find_setting(name).restore_value_after_serialization
      end

      def create_setting_with_default(name, default_value)
        setting = find_or_initialize_by(name: name.to_s)
        setting.set_value_with_serialization(default_value) unless setting.persisted? 
        setting.save!
      end

      private
        def find_setting(name)
          setting = where(name: name.to_s).first
          raise(SettingNotFound, name.to_s) unless setting

          setting
        end
    end
  end
end