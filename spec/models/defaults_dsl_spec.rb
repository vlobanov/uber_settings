require 'spec_helper'

describe UberSettings::DefaultsDSL do
  before(:each) do
    @data_provider = mock()
    @defaults_dsl = UberSettings::DefaultsDSL.new(@data_provider)
  end

  specify { @defaults_dsl.should respond_to :field }
end