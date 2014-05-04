module Troo
  module Commands
    class RefreshAll
      def self.dispatch
        new.refresh_all
      end

      def refresh_all
        return success if refreshed?

        failure
      end

      private

      def success
        'All local data refreshed.'
      end

      def failure
        'Cannot refresh all local data.'
      end

      def refreshed?
        return false if resources.none?

        Troo::Refresh.completed!
        true
      end

      def resources
        @resources ||= external_ids.inject([]) do |acc, id|
          acc << Retrieval::Remote.fetch(Remote::Board, id, mode: :board)
          acc << Retrieval::Remote.fetch(Remote::Comment, id, mode: :board)
          acc
        end
      end

      def external_ids
        all_boards.map(&:id)
      end

      def all_boards
        @boards ||= Retrieval::Remote
          .fetch(Remote::Board, nil, options)
      end

      def options
        {
          mode:    :all,
          persist: false
        }
      end
    end
  end
end
