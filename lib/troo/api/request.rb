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
        return [] unless allow_remote?

        log_request

        @response ||= Response.parse(request)
      rescue RestClient::Exception => e
        ErrorResponse.new(body: e.http_body, code: e.http_code)
      rescue SocketError
        error_no_connection
      rescue Errno::ECONNREFUSED
        error_no_connection
      end

      private

      attr_reader :urn, :verb

      def request
        @request ||= RestClient::Request.execute(
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

      def log_request
        Troo.logger.debug([verb, uri, query].join(' / ')) if log?
      end

      def allow_remote?
        Troo.configuration.allow_remote
      end

      def log?
        Troo.configuration.logs
      end

      def error_no_connection
        ErrorResponse.new(
          body: 'Cannot continue, no network connection.',
          code: 0)
      end
    end
  end
end
