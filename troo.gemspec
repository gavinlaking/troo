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

  spec.add_development_dependency "aruba",          "0.6.2"
  spec.add_development_dependency "bundler",        "1.10.6"
  spec.add_development_dependency "cucumber",       "2.0.0"
  spec.add_development_dependency "fabrication",    "2.13.2"
  spec.add_development_dependency "guard",          "2.12.5"
  spec.add_development_dependency "guard-cucumber", "1.6.0"
  spec.add_development_dependency "guard-minitest", "2.4.4"
  spec.add_development_dependency "minitest",       "5.6.1"
  spec.add_development_dependency "mocha",          "1.1.0"
  spec.add_development_dependency "rake",           "10.4.2"
  spec.add_development_dependency "rubocop",        "0.31.0"
  spec.add_development_dependency "ruby-prof",      "0.15.8"
  spec.add_development_dependency "simplecov",      "0.10.0"
  spec.add_development_dependency "sinatra",        "1.4.6"
  spec.add_development_dependency "vcr",            "2.9.3"
  spec.add_development_dependency "webmock",        "1.21.0"

  spec.add_dependency "addressable",    "2.3.8"
  spec.add_dependency "json",           "1.8.2"
  spec.add_dependency "launchy",        "2.4.3"
  spec.add_dependency "oauth",          "0.4.7"
  spec.add_dependency "ohm",            '1.3.2'
  spec.add_dependency "ohm-contrib",    '1.2'
  spec.add_dependency "rest-client",    "1.8.0"
  spec.add_dependency "term-ansicolor", "1.3.2"
  spec.add_dependency "thor",           '0.19.1'
  spec.add_dependency "vedeu",          "0.5.8"
  spec.add_dependency "virtus",         "1.0.5"
  spec.add_dependency "yajl-ruby",      "1.2.1"
end
