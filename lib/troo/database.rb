module Troo
  class Database
    class << self
      # @param  []
      # @param  []
      # @return []
      def connect(configuration, options = {})
        new(configuration, options).connect
      end
    end

    # @param  []
    # @param  []
    # @return []
    def initialize(configuration, options = {})
      @configuration, @options = configuration, options
    end

    # @return []
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
