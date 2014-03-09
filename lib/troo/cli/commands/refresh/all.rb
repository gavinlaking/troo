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
        @resources ||= external_board_ids.map do |id|
          Retrieval::Remote.fetch(Remote::Board, id, mode: :board)
        end
      end

      def external_board_ids
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