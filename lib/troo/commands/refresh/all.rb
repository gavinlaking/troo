module Troo
  module Commands
    module Refresh
      class All
        def self.dispatch
          new.refresh_all
        end

        def refresh_all
          'All local data refreshed.' if refreshed?
        end

        private

        def refreshed?
          external_board_ids.map do |external_board_id|
            Troo::List.remote(external_board_id, mode: :board)
            Troo::Member.remote(external_board_id, mode: :board)
            Troo::Card.remote(external_board_id, mode: :board).map do |card|
              Troo::Comment.remote(card.external_card_id, mode: :card)
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
          @boards ||= Troo::Board.remote(0, mode: :all)
        end
      end
    end
  end
end
