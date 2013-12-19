require "minitest/autorun"
require "minitest/pride"

module MiniTest
  class Spec
    class << self
      alias_method :context, :describe
    end
  end
end

require_relative "./support/vcr_setup.rb"
require_relative "../lib/troo.rb"

# require "celluloid/test"
# Celluloid.boot

Ohm.connect(db: Troo.config.test_db)

require "mocha/setup"

def database_cleanup(delay = 0.00000001)
  Ohm.redis.flushdb
  sleep delay
end

