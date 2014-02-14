module Troo
  module API
    class Response
      attr_accessor :status, :body

      def initialize(api_response)
        @api_response = api_response
      end

      def status_code
        @status_code ||= api_response.code.to_i
      end

      def body
        if ok?
          @body ||= Yajl::Parser.parse(api_response.body)
        elsif unauthorized?
          raise InvalidAccessToken
        else
          raise GenericAPIError
        end
      end

      private

      attr_reader :api_response

      def ok?
        [200, 201].include?(status_code)
      end

      def unauthorized?
        status_code == 401
      end
    end
  end
end
