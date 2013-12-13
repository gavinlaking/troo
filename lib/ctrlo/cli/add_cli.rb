module Ctrlo
  module CLI
    class Add < Thor
      include Ctrlo::Helpers

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
        result = Ctrlo::CreateList.for(board_id, name)

        Ctrlo::ExternalList.fetch(result.external_board_id, { mode: :board })
      end
    end
  end
end
