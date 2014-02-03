module Troo
  module Commands
    module Refresh
      class All
        def self.dispatch
          new.refresh_all
        end

        def refresh_all
          "All local data refreshed." if refreshed?
        end

        private

        def refreshed?
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
          @boards ||= External::Board.fetch(0, { mode: :all })
        end
      end
    end
  end
end
