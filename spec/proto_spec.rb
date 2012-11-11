require 'spec_helper'

describe Proto do
  it 'should return correct version string' do
    Proto.version_string.should == "Proto version #{Proto::VERSION}"
  end
end