require "minitest/autorun"
require "minitest/pride"

require_relative "./support/vcr_setup.rb"
require_relative "../lib/troo.rb"

# require "celluloid/test"
# Celluloid.boot

# Test Database
Ohm.connect(db: 2)

require "mocha/setup"

