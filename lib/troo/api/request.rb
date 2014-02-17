module Troo
  module API
    class Request
      class << self
        def make(verb, urn, query = {})
          new(verb, urn, query).response
        end
      end

      def initialize(verb, urn, query = {})
        @verb, @urn, @query = verb, urn, query
      end

      def response
        @response ||= Response.parse(request)
      end

      private

      attr_reader :urn, :verb

      def request
        RestClient::Request.execute(
          headers: Headers.build!(uri),
          payload: query,
          timeout: 10,
          method:  verb,
          url:     uri)
      end

      def query
        Addressable::URI.new
          .tap { |u| u.query_values = @query }.query
      end

      def uri
        Addressable::URI.parse(url + urn).to_s
      end

      def url
        Troo.configuration.api_url
      end
    end
  end
end
