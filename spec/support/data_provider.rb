shared_examples "a data provider" do
  before(:each) do
    @provider = described_class
  end

  specify { @provider.should respond_to(:set_value) }
  specify { @provider.should respond_to(:get_value) }

  it "sets values" do
    @provider.set_value(:hello, "no way")
  end

  it "returns value if it was set with #set_value" do
    val = "no way"
    @provider.set_value(:hello, val)
    @provider.get_value(:hello).should == val
  end

  it "treats keys of Symbol and String types as identical" do
    val = rand(0..100000000)
    @provider.set_value("hello", val)
    @provider.get_value(:hello).should == val
  end

  it "shares values between class instances" do
    inst_1 = described_class
    inst_2 = described_class
    inst_1.set_value("hey", 123)
    inst_2.get_value("hey").should == 123
  end

  def self.it_can_store_values_kind_of(value, type_description = nil)
    it "can store #{type_description || value.class.name}" do
      key = rand(0..100000000).to_s
      @provider.set_value(key, value)
      @provider.get_value(key).should == value
    end
  end

  it_can_store_values_kind_of "String"  
  it_can_store_values_kind_of 42  
  it_can_store_values_kind_of 2.4
  it_can_store_values_kind_of true  
  it_can_store_values_kind_of false
  it_can_store_values_kind_of ("Hello, Matz!" * 3000), "Long string"
  it_can_store_values_kind_of UberSettings::CustomizableFile.new("some_filename.rb", "puts 'hello, Matz!'")
end