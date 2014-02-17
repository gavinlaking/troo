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

        if response.is_a?(Array)
          model.with_collection(response)
        else
          [model.new(response)]
        end
      end

      private

      def response
        @response ||= API::Request.make(verb, urn, query)
      end

      def urn
        Troo.endpoints.interpolate!(endpoint, interpolation)
      end

      def missing_parameters?
        verb.nil? || endpoint.nil? || model.nil?
      end
    end
  end
end
