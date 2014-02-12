module Troo
  module API
    class Request
      def initialize(urn, query = {})
        @urn   = urn
        @query = query
      end

      def uri
        Addressable::URI.parse(url + urn).tap do |uri|
          uri.query_values = query if query.any?
        end
      end

      def response
        @response ||= Response.new(http.request(request))
      end

      private

      attr_reader :urn, :query

      def http
        Net::HTTP.new(uri.host, uri.inferred_port).tap do |http|
          http.use_ssl = true
          # http.verify_mode = OpenSSL::SSL::VERIFY_NONE

          http.open_timeout = 2
          http.read_timeout = 5
        end
      end

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
