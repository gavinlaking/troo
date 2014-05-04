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
        return [] if disallow_remote?    ||
                     missing_parameters? ||
                     error_response?     ||
                     empty_response?

        if collection?
          model.with_collection(parsed_response)

        else
          [model.new(parsed_response)]

        end
      end

      private

      def collection?
        parsed_response.is_a?(Array)
      end

      def empty_response?
        parsed_response.empty?
      end

      def error_response?
        response.is_a?(ErrorResponse)
      end

      def parsed_response
        @parsed ||= Yajl::Parser.parse(response.body)
      end

      def response
        @response ||= API::Request.make(verb, uri, query)
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

      def urn
        Troo::API::Endpoints.interpolate(endpoint, interpolation)
      end

      def missing_parameters?
        verb.nil? || endpoint.nil? || model.nil?
      end

      def disallow_remote?
        !(Troo.configuration.allow_remote)
      end

      def external_id
        interpolation[:external_id]
      end
    end
  end
end
