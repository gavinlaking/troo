require "minitest/autorun"
require "minitest/pride"

require_relative "./support/vcr_setup.rb"
require_relative "../lib/troo.rb"

# require "celluloid/test"
# Celluloid.boot

# Test Database

config = YAML.load_file(File.dirname(__FILE__) + "/../configuration.yml")
Ohm.connect(db: config.fetch("test_db", 2))

require "mocha/setup"

