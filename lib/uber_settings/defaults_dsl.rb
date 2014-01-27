module UberSettings
  class DefaultsDSL
    def initialize(data_provider, &block)
      @data_provider = data_provider
      instance_eval(&block) if block
    end

    def field(name, default_value, options = {})
      check_name!(name)
      check_options!(options)
      @data_provider.create_setting_with_default(name, default_value, options)
    end

    UberSettings::DATA_TYPES.each do |type|
      define_method(type) do |name, value, options = {}|
        options[:type] = type
        field(name, value, options)
      end
    end

    private
      def check_name!(name)
        unless name.kind_of?(String) || name.kind_of?(Symbol)
          raise InvalidSettingName, "Name must be String or Symbol"
        end
      end

      def check_options!(options)
        raise InvalidSettingOptions, "Options must be a Hash" unless options.kind_of? Hash

        allowed_options = [:type, :description]
        redundant_options = options.values - allowed_options
        unless redundant_options.empty?
          raise InvalidSettingOptions, "Unexpected options #{redundant_options.join(", ")}"
        end
      end
  end
end