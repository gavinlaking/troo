# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'troo/version'

Gem::Specification.new do |spec|
  spec.name          = "troo"
  spec.version       = Troo::VERSION
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

  spec.add_development_dependency "bundler", "1.5.0.rc.1"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest", "5.0.8"
  spec.add_development_dependency "mocha"
  spec.add_development_dependency "pry", "0.9.12.4"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"

  spec.add_dependency "celluloid"
  spec.add_dependency "data_mapper"
  spec.add_dependency "dm-sqlite-adapter"
  spec.add_dependency "json", "1.7.7"
  spec.add_dependency "ruby-trello"
  spec.add_dependency "term-ansicolor", "1.2.2"
  spec.add_dependency "thor"
end

