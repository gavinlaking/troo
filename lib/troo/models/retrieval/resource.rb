module Troo
  module Retrieval
    class Resource
      attr_reader :id

      class << self
        def default(options = {})
          new(nil, options).retrieve
        end

        def retrieve(id = nil, options = {})
          new(id, options = {}).retrieve
        end
      end

      def initialize(id = nil, options = {})
        @id, @options = id, options
      end

      def retrieve
        return default unless id
        by_short_id || by_id || by_external_id || optional_remote
      end

      private

      def optional_remote
        remote if allow_remote?
      end

      def allow_remote?
        options.fetch(:allow_remote)
      end

      def options
        defaults.merge!(@options)
      end

      def defaults
        { allow_remote: true }
      end

      def default
        nil
      end

      def by_short_id
        nil
      end
    end
  end
end
