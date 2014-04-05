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
        # @param  [Hash]
        # @return []
        def perform(parameters)
          new(parameters).perform
        end
      end

      # @return []
      def perform
        return [] unless allow_remote?
        return [] if missing_parameters?
        return [] if error_response?
        return [] if empty_response?

        log

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
        Troo.endpoints.interpolate!(endpoint, interpolation)
      end

      def missing_parameters?
        verb.nil? || endpoint.nil? || model.nil?
      end

      def allow_remote?
        Troo.configuration.allow_remote
      end

      def log
        Troo.logger.debug(formatted_messages) if log?
      end

      def log?
        Troo.configuration.logs
      end

      def formatted_messages
        messages.map do |label, value|
          [
            [Esc.red, label.rjust(8, ' '), ':', Esc.reset].join, value
          ].join(' ')
        end.join("\n")
      end

      def messages
        request_log.merge!(response_log)
      end

      def request_log
        {
          'Endpoint' => endpoint,
          'Verb'     => verb,
          'URI'      => uri,
          'Query'    => query
        }
      end

      def response_log
        {
          'Status'   => response.code,
          'Response' => response.body
        }
      end
    end
  end
end
