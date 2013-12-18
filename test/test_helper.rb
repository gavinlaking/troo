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

# Test Database

Ohm.connect(db: Troo.config.test_db)

require "mocha/setup"

