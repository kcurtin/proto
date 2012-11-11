# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'proto/version'

Gem::Specification.new do |gem|
  gem.name          = "proto"
  gem.version       = Proto::VERSION
  gem.authors       = ["Kevin Curtin"]
  gem.email         = ["kevincurtin88@gmail.com"]
  gem.description   = %q{Highly malleable, disposable value objects}
  gem.summary       = %q{Highly malleable, disposable value objects}
  gem.homepage      = ""

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency "nokogiri"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  # gem.test_files  = Dir.glob("spec/**/*.rb")
  gem.require_paths = ["lib"]
end
