module Troo
  class Database
    class << self
      def connect(configuration, options = {})
        new(configuration, options).connect
      end
    end

    def initialize(configuration, options = {})
      @configuration, @options = configuration, options
    end

    def connect
      Ohm.connect(db: configuration.database)
    end

    private

    attr_reader :configuration

    def options
      defaults.merge!(@options)
    end

    def defaults
      {}
    end
  end
end
