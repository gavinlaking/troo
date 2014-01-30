module Troo
  module Commands
    class RefreshAll
      def self.dispatch
        new.success
      end

      def success
        "All local data refreshed." if refresh
      end

      private


      def refresh
        external_board_ids.map do |external_board_id|
          External::List.fetch(external_board_id)
          External::Member.fetch(external_board_id)
          External::Card.fetch(external_board_id).map do |card|
            External::Comment.fetch(card.external_card_id, { mode: :card })
          end
        end
        true
      end

      def external_board_ids
        active_boards.map(&:external_board_id)
      end

      def active_boards
        all_boards.delete_if { |b| b.nil? || b.closed == true }
      end

      def all_boards
        @boards ||= External::Board.fetch_all
      end
    end
  end
end
