module UberSettings
  module Settings
    DATA_TYPES = [:string, :text, :integer, :float, :boolean, :file]

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
        self.instance_eval(block)
      end
    end
  end
end