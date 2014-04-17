require 'simplecov'
require 'minitest/autorun'
require 'minitest/pride'
require 'fabrication'

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

Troo::Database
  .connect(Troo::Configuration
    .load('config/trooconf.yml', 'test'))

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
