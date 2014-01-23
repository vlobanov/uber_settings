require 'spec_helper'

describe ArSettings do
  it_behaves_like "a data provider"

  it "exists" do
    ArSettings.new.hello.should == 11
  end
end