module Troo
  module API
    class Client
      include Virtus.model

      attribute :verb
      attribute :endpoint
      attribute :interpolation, Hash
      attribute :query,         Hash
      attribute :model

      class << self
        def perform(parameters)
          new(parameters).perform
        end
      end

      def perform
        return [] if missing_parameters?
        return [] if error_response?
        return [] if empty_response?

        log_endpoint

        if collection?
          model.with_collection(response)
        else
          [model.new(response)]
        end
      end

      private

      def collection?
        response.is_a?(Array)
      end

      def empty_response?
        response.empty?
      end

      def error_response?
        response.is_a?(ErrorResponse)
      end

      def response
        @response ||= API::Request.make(verb, urn, query)
      end

      def urn
        Troo.endpoints.interpolate!(endpoint, interpolation)
      end

      def missing_parameters?
        verb.nil? || endpoint.nil? || model.nil?
      end

      def log_endpoint
        Troo.logger.debug(endpoint) if log?
      end

      def log?
        Troo.configuration.logs
      end
    end
  end
end
