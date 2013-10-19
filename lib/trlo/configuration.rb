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

    def oauth_token
      @oauth_token ||= configuration.fetch('oauth_token')
    end

    def oauth_token_secret
      @oauth_token_secret ||= configuration.fetch('oauth_token_secret')
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
