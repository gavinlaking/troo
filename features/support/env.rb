require 'simplecov'
require 'aruba'
require 'aruba/cucumber'
require 'aruba/in_process'
require 'ohm'
require 'vcr'
require 'webmock/cucumber'
require 'mocha/api'

require_relative '../../lib/troo.rb'

class CucumberError < StandardError; end

Aruba::InProcess.main_class = Troo::Launcher
Aruba.process = Aruba::InProcess

WebMock.disable_net_connect!

VCR.configure do |c|
  c.cassette_library_dir = 'features/support/cassettes'
  c.hook_into :webmock
  c.filter_sensitive_data('<OAuth Credentials>') do |interaction|
    interaction.request.headers['Authorization'].first
  end
end
