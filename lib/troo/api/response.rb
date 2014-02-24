module Troo
  module API
    class Response
      class << self
        def parse(api_response)
          new(api_response).process
        end
      end

      def initialize(api_response)
        @api_response = api_response
      end

      def process
        log_response
        parse
      end

      private

      attr_reader :api_response

      def log_response
        Troo.logger.debug(body) if log?
      end

      def parse
        @parsed ||= Yajl::Parser.parse(body)
      end

      def body
        api_response.body
      end

      def log?
        Troo.configuration.logs
      end
    end
  end
end
