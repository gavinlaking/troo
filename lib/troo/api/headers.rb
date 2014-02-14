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
          "Authorization" => consumer.sign!(wrapper, application)
        }
      end

      def application
        OAuth::Token.new(Troo::Configuration.api_oauth_token,
                         Troo::Configuration.api_oauth_token_secret)
      end

      def wrapper
        Net::HTTP::Get.new(uri)
      end

      def consumer
        OAuth::Consumer.new(Troo::Configuration.api_key,
                            Troo::Configuration.api_token,
                            oauth_settings)
      end

      def oauth_settings
        {
          scheme:             :header,
          scope:              'read,write,account',
          http_method:        :get,
          request_token_path: request_token_path,
          authorize_path:     authorize_path,
          access_token_path:  access_token_path,
          signature_method:   'HMAC-SHA1',
          nonce:              SecureRandom.hex,
          timestamp:          Time.now.to_i,
          uri:                uri
        }
      end

      def request_token_path
        'https://trello.com/1/OAuthGetRequestToken'
      end

      def authorize_path
        'https://trello.com/1/OAuthAuthorizeToken'
      end

      def access_token_path
        'https://trello.com/1/OAuthGetAccessToken'
      end
    end
  end
end
