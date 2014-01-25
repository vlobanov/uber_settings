require 'spec_helper'

describe "Any class with UberSettings::Settings included" do
  before(:each) do
    @settings_class = settings_class_for_testing
  end

  specify { @settings_class.should respond_to :[]  }
  specify { @settings_class.should respond_to :[]= }

  it "delegates [] to data_provider's get_value" do
    @settings_class.data_provider.expects(:get_value).with(:some_key).returns("a value")
    @settings_class[:some_key].should == "a value"
  end

  it "delegates []= to data_provider's set_value" do
    @settings_class.data_provider.expects(:set_value).with(:some_key, "new value")
    @settings_class[:some_key] = "new value"
  end

  def settings_class_for_testing
    settings_class = Class.new
    settings_class.instance_eval do
      include(UberSettings::Settings)
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