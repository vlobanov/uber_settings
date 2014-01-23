require 'spec_helper'
require 'securerandom'

describe UberSettings::CustomizableFile do
  before(:each) do
    @file = UberSettings::CustomizableFile.new("file.rb", "smth")
  end

  describe "Simple methods" do
    specify { @file.should respond_to(:name) }
    specify { @file.should respond_to(:content) }

    it "can be initialized with name only" do
      UberSettings::CustomizableFile.new("file.rb").name.should == "file.rb"
    end

    it "can be initialized with name and content" do
      @file.name.should == "file.rb"
      @file.content.should == "smth"
    end

    it "sets name" do
      @file.name = "hello_name.erl"
      @file.name.should == "hello_name.erl"
    end

    it "sets content" do
      @file.content = "-module(hello_name)."
      @file.content.should == "-module(hello_name)."
    end
  end

  describe "#==" do
    it "returns true for itself" do
      @file.should == @file
    end

    it "returns true for anoter CustomizableFile if both name and content are equal" do
      filename = "#{SecureRandom.hex}.rb"
      content =  SecureRandom.hex(50)
      @file.name = filename
      @file.content = content

      @file.should == UberSettings::CustomizableFile.new(filename, content) 
    end

    it "returns false if object doesn't respond to #name" do
      false_obj = Struct.new(:no_name, :content).new(@file.name, @file.content)
      @file.should_not == false_obj 
    end

    it "returns false if object doesn't respond to #content" do
      false_obj = Struct.new(:name, :no_content).new(@file.name, @file.content)
      @file.should_not == false_obj 
    end

    it "returns true if object responds to #name and #content and corresponding values are equal" do
      false_obj = Struct.new(:name, :content).new(@file.name, @file.content)
      @file.should == false_obj 
    end

    it "returns false if names are not equal" do
      false_obj = Struct.new(:name, :content).new(@file.name + "_", @file.content)
      @file.should_not == false_obj 
    end

    it "returns false if contents are not equal" do
      false_obj = Struct.new(:name, :content).new(@file.name, @file.content + "_")
      @file.should_not == false_obj 
    end
  end

  describe "Serialization" do
    before(:each) do
        
    end

    specify { @file.should respond_to(:marshal_dump) }
    specify { @file.should respond_to(:marshal_load) }

    it "#marshal_dump returns [name, content]" do
      filename = "#{SecureRandom.hex}.rb"
      content =  SecureRandom.hex(50)
      @file.name = filename
      @file.content = content
      @file.marshal_dump.should == [filename, content]
    end

    it "#marshal_load receives [name, content] and sets them" do
      filename = "#{SecureRandom.hex}.rb"
      content =  SecureRandom.hex(50)
      @file.marshal_load([filename, content])
      @file.name.should == filename
      @file.content.should == content
    end
  end
end