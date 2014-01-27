require "spec_helper"

describe OpaqueARSettings do
  it_behaves_like "a opaque settings class"
  
  it "#data_provider returns class, inherited from ActiveRecord::Base" do
    (OpaqueARSettings.send :data_provider).ancestors.should include(ActiveRecord::Base)
  end
end