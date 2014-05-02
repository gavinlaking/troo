module Troo
  module API
    class Responder
      include Virtus.value_object

      values do
        attribute :body, String
        attribute :code, String
      end

      class << self
        # @param  response [Hash]
        # @return [Response, ErrorResponse]
        def build(response)
          new(response).build
        end
      end

      # @return [Response, ErrorResponse]
      def build
        raise ExpiredAccessToken if expired?
        ok? ? Response.new(attributes) : ErrorResponse.new(attributes)
      end

      private

      def expired?
        code == '401'
      end

      def ok?
        code == '200'
      end
    end

    class Response < Responder; end
    class ErrorResponse < Responder; end
  end
end
