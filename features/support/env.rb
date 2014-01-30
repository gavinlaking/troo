require "simplecov"
require "aruba/cucumber"
require "ohm"

SimpleCov.start do
  add_filter   "/test/"
end

require_relative "../../lib/troo.rb"

class CucumberError < StandardError; end
