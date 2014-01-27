module UberSettings
  class DefaultsDSL
    def initialize(data_provider)
      @data_provider = data_provider
    end

    def field(name, default_value, options = {})
      data_provider.create_setting_with_default(name, default_value, options)
    end
  end
end