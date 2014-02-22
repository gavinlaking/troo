module Troo
  module API
    class OAuthSettings
      include Virtus.value_object

      values do
        attribute :scheme,           Symbol,  default: :header
        attribute :http_method,      Symbol,  default: :get
        attribute :timestamp,        Integer, default: Time.now.to_i
        attribute :signature_method, String,  default: 'HMAC-SHA1'

        attribute :nonce,
                  String,
                  default: SecureRandom.hex

        attribute :scope,
                  String,
                  default: 'read,write,account'

        attribute :uri, String

        attribute :request_token_path,
                  String,
                  default: 'https://trello.com/1/OAuthGetRequestToken'

        attribute :authorize_path,
                  String,
                  default: 'https://trello.com/1/OAuthAuthorizeToken'

        attribute :access_token_path,
                  String,
                  default: 'https://trello.com/1/OAuthGetAccessToken'
      end
    end
  end
end
