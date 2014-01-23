module UberSettings
  class CustomizableFile
    attr_accessor :name, :content

    def initialize(name, content = "")
      @name = name
      @content = content
    end

    def marshal_dump
      [@name, @content]
    end

    def marshal_load(vals)
      @name, @content = vals
    end

    def == (another_file)
      return false unless another_file.respond_to?(:name) && another_file.respond_to?(:content)
      another_file.name == @name && another_file.content == @content
    end
  end
end