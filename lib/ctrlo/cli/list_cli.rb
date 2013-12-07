module Ctrlo
  module CLI
    class List < Thor
      include Ctrlo::Helpers

      desc "all", "Show all the lists for the current board or for <board_id>"
      def all(board_id = nil)
        if board_id
          #Output.render(Ctrlo::Board.retrieve(board_id).lists)
        else
          #Output.render(Ctrlo::Board.current.lists)
        end
      rescue => e
        error(e.message)
      end

      desc "cards", "Show all cards for the current list or for <list_id>"
      def cards(list_id = nil)
        if list_id
          "For list_id not implemented yet"
        else
          "For current list not implemented yet"
        end
      end

      desc "current <list_id>", "Set the current list to <list_id>"
      def current(list_id)
        list = SetCurrent.for Ctrlo::List.retrieve(list_id)
      ensure
        notify "'#{list.name}' set to current list."
      end

      desc "add <board_id>", "Add a new list to <board_id>"
      def add(board_id, name = nil)
        result = Ctrlo::CreateList.for(board_id, name)

        Ctrlo::ExternalList.fetch(result.external_board_id, { mode: :board })
      end
    end
  end
end
