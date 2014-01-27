require 'spec_helper'

describe UberSettings::DefaultsDSL do
  before(:each) do
    @data_provider = mock()
    @defaults_dsl = UberSettings::DefaultsDSL.new(@data_provider)
  end

  specify { @defaults_dsl.should respond_to :field }

  it "yields block if passed to constructor" do
    UberSettings::DefaultsDSL.any_instance.expects(:some_instance_method)
    UberSettings::DefaultsDSL.new(@data_provider) do
      some_instance_method
    end
  end

  describe "#field" do
    it "passes name and default value to data_provider's create_setting_with_default, options are empty by default" do
      name = :some_name
      value = 42
      @data_provider.expects(:create_setting_with_default).with(name, value, {})
      @defaults_dsl.field(name, value)
    end

    it "throws exception if name is not string or symbol" do
      name = 123
      expect { @defaults_dsl.field(name, "some value") }.to raise_error(UberSettings::InvalidSettingName)
    end

    it "throws exception if unexpected options are given" do
      expect { @defaults_dsl.field(:ok, :ok_too, weird: "something") }.to raise_error(UberSettings::InvalidSettingOptions)
    end

    it "throws exception if given options is not hash" do
      expect { @defaults_dsl.field(:ok, :ok_too, [:type]) }.to raise_error(UberSettings::InvalidSettingOptions)
    end
  end

  describe "field with type aliases" do
    UberSettings::DATA_TYPES.each do |type|
      specify { @defaults_dsl.should respond_to type }
    end

    def self.it_calls_field_with_type(type, value)
      it "##{type.to_s} calls #field with {type: #{type.inspect}}" do
        name = rand(0..1000).to_s
        @defaults_dsl.expects(:field).with(name, value, {type: type})
        @defaults_dsl.send(type, name, value)
      end
    end

    # DATA_TYPES = [:string, :text, :integer, :float, :boolean, :file]

    it_calls_field_with_type :string, "Some string"
    it_calls_field_with_type :text, "Some string, but as text"
    it_calls_field_with_type :integer, 42
    it_calls_field_with_type :float, 123.55
    it_calls_field_with_type :boolean, 123.55
  end


end