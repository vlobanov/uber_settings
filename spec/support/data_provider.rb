shared_examples "a data provider" do
  before(:each) do
    @provider = described_class
  end

  specify { @provider.should respond_to(:set_value) }
  specify { @provider.should respond_to(:get_value) }

  describe "::create_setting_with_default" do
    it "creates setting with default value if not found" do
      @provider.create_setting_with_default(:some_name, "a value")
    end

    it "doesn't change value if setting existed" do
      @provider.create_setting_with_default(:some_name, "a value")
      @provider.set_value(:some_name, "no way")
      @provider.create_setting_with_default(:some_name, "a new value")
      @provider.get_value(:some_name).should == "no way"
    end

    it "can take options as third argument" do
      @provider.create_setting_with_default(:some_name, "a value", {})
    end

    describe "attributes" do
      it "creates setting with default value if not found" do
        @provider.create_setting_with_default(:some_name, "a value")
      end
    end
  end

  context "when setting was created with :type option" do
    it "next set_value with value of other type will raise UberSettings::InvalidSettingValueType" do
      @provider.create_setting_with_default(:hello, "a default value", type: :string)
      expect { @provider.set_value(:hello, Object.new) }.to raise_error(UberSettings::InvalidSettingValueType)
    end

    it "raises exception if type is unknown" do
      expect { @provider.create_setting_with_default(:hello, "a default value", type: :bs) }.to raise_error(UberSettings::UnknownSettingValueType)
    end
  end

  describe "::set_value and ::get_value" do
    describe "For existed setting" do
      before(:each) do
        @provider.create_setting_with_default(:hello, "a default value")
      end

      it "#get_value returns default value if it was not changed" do
        @provider.get_value(:hello).should == "a default value"
      end

      it "sets values" do
        @provider.set_value(:hello, "no way")
      end
    
      it "returns value if it was set with ::set_value" do
        val = "no way"
        @provider.set_value(:hello, val)
        @provider.get_value(:hello).should == val
      end

      it "treats keys of Symbol and String types as identical" do
        val = rand(0..100000000)
        @provider.set_value("hello", val)
        @provider.get_value(:hello).should == val
      end
    end

    it "::set_value raises UberSettings::SettingNotFound if non-existing property was requested" do
      expect { @provider.set_value(:cant_set_me, "anything") }.to raise_error(UberSettings::SettingNotFound, "cant_set_me")
    end

    it "::get_value raises UberSettings::SettingNotFound if non-existing property was requested" do
      expect { @provider.get_value(:cant_get_me) }.to raise_error(UberSettings::SettingNotFound, "cant_get_me")
    end
  end

  def self.it_can_store_values_kind_of(value, type_description = nil)
    it "can store #{type_description || value.class.name}" do
      key = rand(0..100000000).to_s
      @provider.create_setting_with_default(key, value)
      @provider.get_value(key).should == value
    end
  end

  it_can_store_values_kind_of "String"  
  it_can_store_values_kind_of 42  
  it_can_store_values_kind_of 2.4
  it_can_store_values_kind_of true  
  it_can_store_values_kind_of false
  it_can_store_values_kind_of ("Hello, Matz! " * 3000), "Long string"
  it_can_store_values_kind_of UberSettings::CustomizableFile.new("some_filename.rb", "puts 'hello, Matz!'")
end