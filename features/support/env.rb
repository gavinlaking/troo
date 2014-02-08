require "simplecov"
require "aruba"
require "aruba/cucumber"
require "aruba/in_process"
require "ohm"
require "vcr"
require "webmock/cucumber"

SimpleCov.start do
  add_filter   "/test/"
end

require_relative "../../lib/troo.rb"

class CucumberError < StandardError; end

Aruba::InProcess.main_class = Troo::Launcher
Aruba.process = Aruba::InProcess

WebMock.disable_net_connect!

VCR.configure do |c|
  c.cassette_library_dir = 'features/support/fixtures/cassettes'
  c.hook_into :webmock
  #c.debug_logger = File.open("logs/vcr.log", 'w')
  c.filter_sensitive_data('<OAuth Credentials>') do |interaction|
    interaction.request.headers['Authorization'].first
  end
end
