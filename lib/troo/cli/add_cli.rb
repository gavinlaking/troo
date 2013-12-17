module Troo
  module CLI
    class Add < Thor
      desc "board", "Add a new board"
      def board(name)
        "Not implemented yet."
      end

      desc "card <list_id>", "Add a new card to <list_id>"
      def card(list_id, name = nil)
        "Not implemented yet."
      end

      desc "list <board_id>", "Add a new list to <board_id>"
      def list(board_id, name = nil)
        # result = Troo::CreateList.for(board_id, name)

        # Troo::ExternalList.fetch(result.external_board_id, { mode: :board })
        "Not implemented yet."
      end
    end
  end
end
