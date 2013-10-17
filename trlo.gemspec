# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'trlo/version'

Gem::Specification.new do |spec|
  spec.name          = "trlo"
  spec.version       = Trlo::VERSION
  spec.authors       = ["Gavin Laking"]
  spec.email         = ["gavin.laking@onthebeach.co.uk"]
  spec.description   = %q{CLI interface for Trello.}
  spec.summary       = spec.description
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "1.3.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest", "4.7.5"
end
