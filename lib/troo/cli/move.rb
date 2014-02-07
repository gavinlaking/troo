module Troo
  module CLI
    class Move < ThorFixes
      package_name "move"

      desc "move <card_id> <list_id> (<board_id>)",
           "Move card with <card_id> to list with <list_id>, optionally to another board with <board_id>."
      def move(card_id, list_id, board_id = nil)
        say Commands::Move::Card.dispatch(card_id, list_id, board_id)
      end
    end
  end
end
