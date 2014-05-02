module Troo
  module API
    class Request
      class << self
        # @param  verb  [Symbol]
        # @param  uri   [String]
        # @param  query [Hash]
        # @return [Response, ErrorResponse]
        def make(verb, uri, query = {})
          new(verb, uri, query).make
        end
      end

      # @param  verb  [Symbol]
      # @param  uri   [String]
      # @param  query [Hash]
      # @return [Troo::API::Request]
      def initialize(verb, uri, query = {})
        @verb, @uri, @query = verb, uri, query
      end

      # @return [Response, ErrorResponse]
      def make
        @request ||= request
      rescue RestClient::Exception => e
        ErrorResponse.new(body: e.http_body, code: e.http_code)
      rescue SocketError, Errno::ECONNREFUSED
        ErrorResponse.new(body: 'Cannot reach Trello.', code: 0)
      end

      private

      attr_reader :query, :uri, :verb

      def request
        RestClient::Request.execute(headers: Headers.build!(uri),
                                    payload: query,
                                    timeout: 10,
                                    method:  verb,
                                    url:     uri) do |response|
          Responder.build(body: response.body, code: response.code)
        end
      end
    end
  end
end
