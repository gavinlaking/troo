module Ctrlo
  module CLI
    class List < Thor
      include Ctrlo::Helpers

      desc "add <board_id>", "Add a new list to <board_id>"
      def add(board_id, name = nil)
        result = Ctrlo::CreateList.for(board_id, name)

        Ctrlo::ExternalList.fetch(result.external_board_id, { mode: :board })
      end

      desc "all <board_id>", "Show all the lists for board <board_id>"
      def all(board_id)
        Ctrlo::CLI::Board.new.lists(board_id)
      end

      desc "show <list_id>", "Show all cards for list <list_id>"
      def show(list_id)
        if list_id.nil?
          raise Trello::Error
        else
          puts Ctrlo::ListPresenter.render(
                 Ctrlo::ListRetrieval.retrieve(list_id), { show_lists:  true,
                                                           show_cards:  true })
        end
      rescue Trello::Error
        puts "List cannot be found."
      end
    end
  end
end
