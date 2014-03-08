module Troo
  module API
    class Request
      class << self
        def make(verb, uri, query = {})
          new(verb, uri, query).make
        end
      end

      def initialize(verb, uri, query = {})
        @verb, @uri, @query = verb, uri, query
      end

      def make
        @request ||= request
      rescue RestClient::Exception => e
        ErrorResponse.new(body: e.http_body, code: e.http_code)
      rescue SocketError, Errno::ECONNREFUSED
        ErrorResponse.new
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
