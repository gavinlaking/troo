module Troo
  module Retrieval
    class Local
      attr_reader :id

      class << self
        def all(klass)
          new(klass).all
        end

        def default(klass, options = {})
          new(klass, nil, options).default
        end

        def retrieve(klass, id = nil, options = {})
          new(klass, id, options = {}).retrieve
        end
      end

      def initialize(klass, id = nil, options = {})
        @klass, @id, @options = klass, id, options
      end

      def all
        klass.all
      end

      def default
        klass.default
      end

      def retrieve
        return default unless id
        by_short_id || by_id || by_external_id || optional_remote
      end

      private

      attr_reader :klass

      def optional_remote
        remote if allow_remote?
      end

      def allow_remote?
        Troo.configuration.allow_remote &&
          options.fetch(:allow_remote)
      end

      def options
        defaults.merge!(@options)
      end

      def defaults
        { allow_remote: true }
      end

      def by_id
        klass[id]
      end

      def by_short_id
        klass.first(short_id: id)
      end

      def by_external_id
        klass.by_external_id(id)
      end

      def remote
        klass.fetch(id, options).first
      end
    end
  end
end
