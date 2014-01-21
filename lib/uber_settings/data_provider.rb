module UberSettings
  class DataProvider
    def initialize
      @values ||= {}
    end
    
    def set_value(name, value)
      @values[name.to_s] = value
    end

    def get_value(name)
      @values[name.to_s]
    end
  end
end