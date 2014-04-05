module Troo
  module Retrieval
    class Local
      attr_reader :id

      class << self
        # @param  []
        # @return []
        def all(klass)
          new(klass).all
        end

        # @param  []
        # @param  [Hash]
        # @return []
        def default(klass, options = {})
          new(klass, nil, options).default
        end

        # @param  []
        # @param  []
        # @param  [Hash]
        # @return []
        def retrieve(klass, id = nil, options = {})
          new(klass, id, options).retrieve
        end
      end

      # @param  []
      # @param  []
      # @param  [Hash]
      # @return []
      def initialize(klass, id = nil, options = {})
        @klass, @id, @options = klass, id, options
      end

      # @return []
      def all
        klass.all
      end

      # @return []
      def default
        klass.default
      end

      # @return []
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
        klass.first(short_id_criteria)
      end

      def by_external_id
        klass.by_external_id(id)
      end

      def remote
        Retrieval::Remote.fetch(klass.remote, id, options).first
      end

      def short_id_criteria
        return special if card? && default_board_exists?
        normal
      end

      def normal
        { short_id: id }
      end

      def special
        if klass.count(normal) > 1
          normal.merge!(board_criteria)
        else
          normal
        end
      end

      def board_criteria
        { external_board_id: Troo::Board.default.external_id }
      end

      def card?
        klass.type.eql?(:card)
      end

      def default_board_exists?
        !!(Troo::Board.default)
      end
    end
  end
end
