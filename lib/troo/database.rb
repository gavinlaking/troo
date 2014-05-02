module Troo
  class Database
    class << self
      # @param  configuration []
      # @param  options       [Hash]
      # @return []
      def connect(configuration, options = {})
        new(configuration, options).connect
      end
    end

    # @param  configuration []
    # @param  options       [Hash]
    # @return [Troo::Database]
    def initialize(configuration, options = {})
      @configuration, @options = configuration, options
    end

    # @return [NilClass]
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
