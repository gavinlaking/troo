module Troo
  module API
    class Response
      class << self
        def parse(api_response)
          new(api_response).parse
        end
      end

      def initialize(api_response)
        @api_response = api_response
      end

      def body
        @parsed ||= Yajl::Parser.parse(api_response.body)
      end
      alias_method :parse, :body

      private

      attr_reader :api_response
    end
  end
end
