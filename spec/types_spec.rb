require 'spec_helper'

describe "UberSettings::DATA_TYPES_PREDICATES" do
  it "is defined" do
    defined?(UberSettings::DATA_TYPES_PREDICATES).should == "constant"
  end

  it "has same keys as UberSettings::DATA_TYPES" do
    UberSettings::DATA_TYPES_PREDICATES.keys.should == UberSettings::DATA_TYPES
  end

  it "has each value a predicate" do
    UberSettings::DATA_TYPES_PREDICATES.values.each do |predicate|
      predicate.should respond_to :call
      predicate.arity.should == 1
    end
  end

  describe "predicates" do
    def self.positive_for(type, examples)
      examples.each do |name, sample|
        it "accepts #{name}" do
          UberSettings::DATA_TYPES_PREDICATES[type].call(sample).should == true
        end
      end
    end

    def self.negative_for(type, examples)
      examples.each do |name, sample|
        it "denies #{name}" do
          UberSettings::DATA_TYPES_PREDICATES[type].call(sample).should == false
        end
      end
    end

    describe "integer" do
      positive_for :integer, "fixnums" => 123
      negative_for :integer, "strings" => "hello"
    end

    describe "float" do
      positive_for :float, "integers" => 123, "floats" => 0.5
      negative_for :float, "strings" => "hello"
    end

    describe "string" do
      positive_for :string, "strings" => "hello" 
      negative_for :string, "integers" => 123, "objects" => Object.new, "symbols" => :hello
    end

    describe "text" do
      positive_for :text, "long strings" => "hello " * 1000 
      negative_for :text, "integers" => 123, "objects" => Object.new, "symbols" => :hello
    end

    describe "boolean" do
      positive_for :boolean, "true" => true, "false" => false, "nil" => nil 
      negative_for :boolean, "integers" => 12314, "objects" => Object.new 
    end

    describe "file" do
      positive_for :file, "CustomizableFile" => UberSettings::CustomizableFile.new("file.rb", "content") 
      negative_for :file, "objects" => Object.new 
    end
  end
end