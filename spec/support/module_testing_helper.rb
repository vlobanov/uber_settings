module ModuleTestingHelper
  def settings_class_for_testing(*modules_to_include)
    settings_class = Class.new
    settings_class.instance_eval do
      modules_to_include.each { |mod| include(mod) }
      
      def data_provider
        @data_provider
      end

      def data_provider= dp
        @data_provider = dp
      end
    end

    settings_class.data_provider = mock()

    settings_class
  end
end