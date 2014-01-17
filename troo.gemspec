# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'troo/version'

Gem::Specification.new do |spec|
  spec.name          = "troo"
  spec.version       = Troo::VERSION
  spec.authors       = ["Gavin Laking"]
  spec.email         = ["gavinlaking@gmail.com"]
  spec.description   = %q{CLI interface for Trello.}
  spec.summary       = spec.description
  spec.homepage      = "http://gavinlaking.name"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "aruba",          "0.5.4"
  spec.add_development_dependency "bundler",        "1.5.2"
  spec.add_development_dependency "cucumber",       "1.3.10"
  spec.add_development_dependency "fabrication",    "2.9.3"
  spec.add_development_dependency "guard",          "2.2.5"
  spec.add_development_dependency "guard-minitest", "2.1.3"
  spec.add_development_dependency "minitest",       "5.0.8"
  spec.add_development_dependency "mocha",          "0.14.0"
  spec.add_development_dependency "pry",            "0.9.12.4"
  spec.add_development_dependency "rake",           "10.1.1"
  spec.add_development_dependency "simplecov",      "0.8.2"
  spec.add_development_dependency "vcr",            "2.8.0"
  spec.add_development_dependency "webmock",        "1.15.2"

  spec.add_dependency "json",           "1.7.7"
  spec.add_dependency "ohm",            "1.3.2"
  spec.add_dependency "ohm-contrib",    "1.2"
  spec.add_dependency "ruby-trello",    "1.1.0"
  spec.add_dependency "term-ansicolor", "1.2.2"
  spec.add_dependency "thor",           "0.18.1"
end

