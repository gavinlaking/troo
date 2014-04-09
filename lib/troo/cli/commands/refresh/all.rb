module Troo
  module Commands
    class RefreshAll
      # @return [String]
      def self.dispatch
        new.refresh_all
      end

      # @return [String]
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
        @resources ||= external_ids.map do |id|
          Retrieval::Remote.fetch(Remote::Board, id, mode: :board)

          Retrieval::Remote.fetch(Remote::Comment, id, mode: :board)
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
