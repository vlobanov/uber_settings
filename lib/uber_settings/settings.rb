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
    end
  end
end