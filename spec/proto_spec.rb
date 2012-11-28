require 'spec_helper'

describe Proto do
  it 'should return correct version string' do
    "0.0.3" == "Proto version #{Proto::VERSION}"
  end
end