require 'spec_helper'

describe UberSettings do
  it "has DATA_TYPES array" do
    UberSettings::DATA_TYPES.should be_kind_of Array
  end
end