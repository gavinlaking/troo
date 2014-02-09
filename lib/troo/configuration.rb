module Troo
  class Configuration
    include Singleton

    attr_reader :config

    class << self
      def load(file, env)
        instance.load(file, env)
      end

      def api_url
        instance.api_url
      end

      def api_key
        instance.api_key
      end

      def api_token
        instance.api_token
      end

      def main_db
        instance.main_db
      end

      def test_db
        instance.test_db
      end
    end

    def load(file, env)
      @config = YAML.load_file(file)[env.to_s]
    end

    def api_url
      'https://api.trello.com/1'
    end

    def api_key
      config.fetch('api_key', nil) || config.fetch('key', '')
    end
    alias_method :key, :api_key

    def api_token
      config.fetch('api_token', nil) || config.fetch('secret', '')
    end
    alias_method :secret, :api_token

    def main_db
      config.fetch('main_db', '')
    end

    def test_db
      config.fetch('test_db', '')
    end
  end
end
