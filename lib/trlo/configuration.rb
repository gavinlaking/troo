module Trlo
  class Configuration
    include Singleton

    def initialize
      @configuration = {}
    end

    def self.load!(file)
      instance.load(file)
    end

    def load(file)
      @configuration = YAML.load_file(file)
    end

    def key
      @key ||= configuration.fetch('key')
    end

    def secret
      @secret ||= configuration.fetch('secret')
    end

    private

    attr_reader :configuration
  end

  def self.configuration
    Configuration.instance
  end

  def self.configure
    yield(configuration)
  end
end
