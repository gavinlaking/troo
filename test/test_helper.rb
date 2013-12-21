require "minitest/autorun"
require "minitest/pride"
require "fabrication"

module MiniTest
  class Spec
    class << self
      alias_method :context, :describe
    end
  end
end

require_relative "./support/vcr_setup.rb"
require_relative "../lib/troo.rb"
require_relative "./support/fabrication.rb"

# require "celluloid/test"
# Celluloid.boot

Ohm.connect(db: Troo.config.test_db)

require "mocha/setup"

def database_cleanup(delay = 0)
  Ohm.redis.flushdb
  sleep delay if delay > 0
end
