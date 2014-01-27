require "spec_helper"

describe OpaqueMongoidSettings do
  it_behaves_like "a opaque settings class"
  
  it "#data_provider returns class with Mongoid::Document included" do
    (OpaqueMongoidSettings.send :data_provider).ancestors.should include(Mongoid::Document)
  end
end