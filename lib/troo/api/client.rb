module Troo
  module API
    class Client

      def initialize(urn, query = {})
        @urn   = urn
        @query = query
      end

      def uri
        a = Addressable::URI.parse(url + urn).tap do |uri|
          uri.query_values = query unless query.empty?
        end
      end

      private

      attr_reader :urn, :query

      def url
        Troo::Configuration.api_url
      end

      def query
        credentials.merge!(@query)
      end

      def credentials
        {
          key:   Troo::Configuration.api_key,
          token: Troo::Configuration.api_token
        }
      end
    end
  end
end
