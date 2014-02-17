module Troo
  module API
    class Response
      attr_accessor :status, :body

      class << self
        def parse(api_response)
          new(api_response).parse
        end
      end

      def initialize(api_response)
        @api_response = api_response
      end

      def status_code
        @status_code ||= api_response.code.to_i
      end

      def body
        return parsed_response  if ok?
        fail InvalidAccessToken if unauthorized?
        fail GenericAPIError
      end
      alias_method :parse, :body

      private

      attr_reader :api_response

      def parsed_response
        @body ||= Yajl::Parser.parse(api_response.body)
      end

      def ok?
        [200, 201].include?(status_code)
      end

      def unauthorized?
        status_code == 401
      end
    end
  end
end
