require 'spec_helper'

describe "Any class with UberSettings::Settings included" do
  include ModuleTestingHelper

  before(:each) do
    @settings_class = settings_class_for_testing(UberSettings::Settings)
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
end