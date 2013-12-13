module Troo
  module CLI
    class Add < Thor
      include Troo::Helpers

      desc "board", "Add a new board"
      def board(name = nil)
        puts "Not implemented yet."
      end

      desc "card <list_id>", "Add a new card to <list_id>"
      def card(list_id, name = nil)
        puts "Not implemented yet."
      end

      desc "list <board_id>", "Add a new list to <board_id>"
      def list(board_id, name = nil)
        result = Troo::CreateList.for(board_id, name)

        Troo::ExternalList.fetch(result.external_board_id, { mode: :board })
      end
    end
  end
end
