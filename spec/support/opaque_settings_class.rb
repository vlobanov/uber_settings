shared_examples "a opaque settings class" do
  it "#data_provider is private" do
    described_class.private_methods.should include(:data_provider)
  end

  it "has UberSettings::Settings included" do
    described_class.ancestors.should include(UberSettings::Settings)
  end

  it "can set default values" do
    described_class.defaults do
      field :some_field, 12345
    end
  end

  it "can read default values" do
    described_class.defaults do
      field :some_field, 12345
    end

    described_class[:some_field].should == 12345
  end

  it "can change default values" do
    described_class.defaults do
      field :some_field, 12345
    end

    described_class[:some_field] = -12345
    described_class[:some_field].should == -12345
  end
end