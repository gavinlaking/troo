module Troo
  module Retrieval
    class Resource
      attr_reader :id

      class << self
        def default
          new.retrieve
        end

        def retrieve(id = nil)
          new(id).retrieve
        end
      end

      def initialize(id = nil)
        @id = id
      end

      def retrieve
        return default unless id
        by_short_id || by_id || by_external_id || remote
      end

      private

      def default
        nil
      end

      def by_short_id
        nil
      end
    end
  end
end
