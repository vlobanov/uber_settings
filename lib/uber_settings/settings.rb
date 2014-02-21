module UberSettings
  module Settings
    def self.included(klass)
      klass.instance_eval do
        extend(ClassMethods)
      end
    end

    module ClassMethods
      def [](name)
        data_provider.get_value(name)
      end

      def []=(name, value)
        data_provider.set_value(name, value)
      end

      def defaults(&block)
        DefaultsDSL.new(data_provider, &block)
      end

      private
        def init_ar_data_provider
          @data_provider = Class.new(::ActiveRecord::Base) do
            self.table_name= "ar_settings"
            include UberSettings::ActiveRecord
          end
        end

        def init_mongoid_data_provider
          data_provider_class_name = self.name + "DataProvider"
          @data_provider = Class.new do
            @class_name_for_mongoid_collection = data_provider_class_name
            
            def self.name
              @class_name_for_mongoid_collection
            end

            include ::Mongoid::Document
            include UberSettings::Mongoid
          end
        end

        def init_data_provider
          suggest_data_provider unless @data_provider_type
          case @data_provider_type
          when :active_record then init_ar_data_provider
          when :mongoid then init_mongoid_data_provider
          else raise UnknownDataProvider
          end
        end

        def data_provider
          init_data_provider unless @data_provider
          @data_provider
        end

        def suggest_data_provider
          if defined?(::ActiveRecord::Base)
            @data_provider_type = :active_record
          elsif defined?(::Mongoid::Document)
            @data_provider_type = :mongoid
          end
        end
    end
  end
end