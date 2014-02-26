module Troo
  module API
    class Headers
      class << self
        def build!(uri, headers = {})
          new(uri, headers).build!
        end
      end

      def initialize(uri, headers = {})
        @uri, @headers = uri, headers
      end

      def build!
        defaults.merge!(@headers)
      end

      private

      attr_reader :uri

      def defaults
        {
          'Authorization' => consumer.sign!(wrapper, application)
        }
      end

      def application
        OAuth::Token.new(Troo.configuration.api_oauth_token,
                         Troo.configuration.api_oauth_token_secret)
      end

      def wrapper
        Net::HTTP::Get.new(uri)
      end

      def consumer
        OAuth::Consumer.new(Troo.configuration.api_key,
                            Troo.configuration.api_token,
                            OAuthSettings.new(uri: uri).to_hash)
      end
    end
  end
end
