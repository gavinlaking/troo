require "aruba"
require "simplecov"
require "aruba/cucumber"
require "aruba/in_process"
require "ohm"

SimpleCov.start do
  add_filter   "/test/"
end

require_relative "../../lib/troo.rb"

class CucumberError < StandardError; end

Aruba::InProcess.main_class = Troo::Launcher
Aruba.process = Aruba::InProcess
