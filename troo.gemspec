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

  spec.add_development_dependency "aruba"
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "cucumber"
  spec.add_development_dependency "fabrication"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-cucumber"
  spec.add_development_dependency "guard-minitest"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "mocha"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "ruby-prof"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "sinatra"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "yard"

  spec.add_dependency "addressable"
  spec.add_dependency "curses",         '1.0.1'
  spec.add_dependency "dispel"
  spec.add_dependency "json"
  spec.add_dependency "launchy"
  spec.add_dependency "oauth"
  spec.add_dependency "ohm",            '1.3.2'
  spec.add_dependency "ohm-contrib",    '1.2'
  spec.add_dependency "pry"
  spec.add_dependency "pry-nav"
  spec.add_dependency "rest-client"
  spec.add_dependency "term-ansicolor"
  spec.add_dependency "thor",           '0.18.1'
  spec.add_dependency "virtus"
  spec.add_dependency "yajl-ruby"
end
