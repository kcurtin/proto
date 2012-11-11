require 'rspec'
require 'proto'

require File.expand_path(File.dirname(__FILE__) + '/../lib/proto')

def load_sample(filename)
  File.read("#{File.dirname(__FILE__)}/sample_pages/#{filename}")
end

def sample_atom_feed
  load_sample("twitter.html")
end

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter     = 'documentation'
end