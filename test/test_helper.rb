require 'simplecov'
require 'minitest/autorun'
require 'minitest/pride'
require 'fabrication'

SimpleCov.start do
  command_name 'MiniTest::Spec'
  add_filter   '/test/'
end

module MiniTest
  class Spec
    class << self
      alias_method :context, :describe
    end
  end
end

require_relative './support/vcr_setup.rb'
require_relative '../lib/troo.rb'
require_relative './support/fabrication.rb'

database = Troo::Configuration.load('test/support/.trooconf', :test).database
Ohm.connect(db: database)

require 'mocha/setup'

def database_cleanup(delay = 0)
  Ohm.redis.flushdb
  sleep delay if delay > 0
end

def mock_trello_response(filename, klass)
  json = File.read('./test/support/remotes/' + filename)
  hash = Yajl::Parser.parse(json)
  klass.new(hash)
end
